
genesis.js
==========

[![Software License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)


Node.js client library for Genesis Payment Gateway

Overview
--------

Client Library for processing payments through Genesis Payment Processing Gateway. Its highly recommended to checkout "Genesis Payment Gateway API Documentation" first, in order to get an overview of Genesis's Payment Gateway API and functionality.

Requirements
------------

* node.js v8.16.2 or newer
* npm


Installation
------------

```sh
npm install genesis.js
```

Getting Started
---------------

In order to process transactions via Genesis, you'll have to acquire the necessary credentials in order to connect to the Gateway.

Configuration
-------------

You can override the path to the directory holding your configuration files (by default its ```config``` in the root directory of the module) via environmental variable ```NODE_CONFIG_DIR```. The first file to parse configuration from, is ```<your-config-dir>/default.json``` and based on the environment variable (```NODE_ENV```), you can specify your custom file; for example ```<your-config-dir>/<NODE_ENV_NAME>.json```.

Note: Its good practice to prevent web/direct access to your config directory and protect the files inside

Sale Transaction
----------------

- JavaScript

```js
var crypto, failure, genesis, success, transaction;

genesis = require('./lib/genesis.js');

crypto = require('crypto');

transaction = new genesis.transaction();

failure = function(reason) {
  return console.log(reason);
};

success = function(data) {
  return console.log(data);
};

transaction.sale({
    transaction_id: crypto.randomBytes(16).toString('hex'),
    usage: 'Demo Payment Transaction',
    description: 'This is my first payment',
    remote_ip: '127.0.0.1',
    amount: '100',
    currency: 'USD',
    card_holder: 'John Doe',
    card_number: '4200000000000000',
    cvv: '000',
    expiration_month: 12,
    expiration_year: 2020,
    customer_email: 'email@example.com',
    customer_phone: '0123456789',
    billing_address: {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'US'
    }
  })
  .send()
  .then(success)
  .catch(failure);
```

- CoffeeScript

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
    console.log reason

success = (data) ->
   console.log data

transaction.sale({
    transaction_id    : crypto.randomBytes(16).toString('hex')
    usage             : 'Demo Payment Transaction'
    description       : 'This is my first payment'
    remote_ip         : '127.0.0.1'
    amount            : '100'
    currency          : 'USD'
    card_holder       : 'John Doe'
    card_number       : '4200000000000000'
    cvv               : '000'
    expiration_month  : 12
    expiration_year   : 2020
    customer_email    : 'email@example.com'
    customer_phone    : '0123456789'
    billing_address   :
        first_name: 'John'
        last_name : 'Doe'
        address1  : '123 Str.'
        zip_code  : '10000'
        city      : 'New York'
        country   : 'US'
    })
    .send()
    .then(success)
    .catch(failure)
```

The example above is going to create a Sale (Authorize w/ immediate Capture) transaction for the amount of $100.

Web Payment Form Transaction
----------------------------

- JavaScript

```js
var crypto, failure, genesis, success, transaction;

genesis = require('./lib/genesis.js');

crypto = require('crypto');

transaction = new genesis.transaction();

failure = function(reason) {
  return console.log(reason);
};

success = function(data) {
  return console.log(data);
};

transaction.wpf_create({
    locale: 'de',
    transaction_id: crypto.randomBytes(16).toString('hex'),
    usage: 'Demo WPF Transaction',
    description: 'This is my first WPF transaction',
    remote_ip: '127.0.0.1',
    amount: '100',
    currency: 'USD',
    customer_email: 'email@example.com',
    customer_phone: '0123456789',
    notification_url: 'http://my.host.name.tld:1234/notifier',
    return_success_url: 'http://my.host.name.tld/success',
    return_failure_url: 'http://my.host.name.tld/failure',
    return_cancel_url: 'http://my.host.name.tld/cancel',
    billing_address: {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'US'
    },
    transaction_types: ['authorize3d', 'sale']
  })
  .send()
  .then(success)
  .catch(failure);
```

- CoffeeScript

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (error, body) ->
    console.log error, body

success = (response, body) ->
   console.log body
   
transaction.wpf_create({
    locale            : 'de'
    transaction_id    : crypto.randomBytes(16).toString('hex')
    usage             : 'Demo WPF Transaction'
    description       : 'This is my first WPF transaction'
    remote_ip         : '127.0.0.1'
    amount            : '100'
    currency          : 'USD'
    customer_email    : 'email@example.com'
    customer_phone    : '0123456789'
    notification_url  : 'http://my.host.name.tld:1234/notifier'
    return_success_url: 'http://my.host.name.tld/success'
    return_failure_url: 'http://my.host.name.tld/failure'
    return_cancel_url : 'http://my.host.name.tld/cancel'
    billing_address   :
        first_name: 'John'
        last_name : 'Doe'
        address1  : '123 Str.'
        zip_code  : '10000'
        city      : 'New York'
        country   : 'US'
    transaction_types: [
        'authorize3d'
        'sale'
    ]
  })
  .send()
  .then(success)
  .catch(failure)
```

The example above is going to create a new ```WPF``` instance with German (```de```) locale and allowed transaction types - ```authorize3d``` (Authorize w/ 3D-Secure asynchronously) and ```sale``` for the amount of $100.


Notification Listener
---------------------

- JavaScript

```js
var success, failure, genesis, notification, notification_url;

genesis = require('./lib/genesis.js');

notification = new genesis.notification();

success = function(result) {
  return console.log(result);
};

failure = function(error) {
  return console.log(error);
};

notification.listen(success, failure);

notification_url = notification.getUrl();
```

- CoffeeScript

```coffee
genesis = require './lib/genesis.js'

notification = new genesis.notification()

success = (result) =>
  console.log result
  
failure = (error) =>
  console.log error

notification.listen success, failure

notification_url = notification.getUrl()
```

The example above would create a notification listener on ```my.host.name.tld:1234/notifier``` which you can use as notification handler for async transactions. If a notification is received and its successfully verified against our backend, the callback will be called with details of the transaction you're being notified for.

Handle notifications with separate web server
---------------------

In case you have already setup web server and do not what to start another. 
Or you just what to use different one like [Express](https://expressjs.com/) for example. 

You can accomplish this by calling handle method in your web server route.

Request and response objects should be enhanced versions of Node’s own request/response objects and support all [built-in fields and methods](https://nodejs.org/api/http.html#http_class_http_incomingmessage)!

- JavaScript
```js
var genesis, notification;

genesis = require('./lib/genesis.js');

notification = new genesis.notification();

var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({ extended: true })

router.post('/listen', urlencodedParser, function (request, response) {
    notification.handle(request, response)
        .then(console.log)
        .catch(console.log);
});
```

- CoffeeScript

```coffee
genesis = require './lib/genesis.js'

notification = new genesis.notification()

bodyParser = require 'body-parser'
urlencodedParser = bodyParser.urlencoded({ extended: true })

router.post('/listen', urlencodedParser, (request, response) ->
    notification.handle(request, response)
      .then console.log
      .catch console.log
```
Response
--------

#### Success callback

You receive a successful Transaction Execution response in JSON format. The data contains a `status`.


If the Transaction is Successful the status is one of the following:
  * `new`
  * `approved`
  * `pending_async`
  
  <details>
  <summary>Example Successful Transaction Execution</summary>
  
  ```object
  { 
    status: 'new',
    unique_id: '9ee21d5a35a3a08615b2082077a5f529',
    transaction_id: '706103ba5c4683296d16379220770699',
    timestamp: '2021-07-29T13:12:02Z',
    amount: '100.00',
    currency: 'USD',
    redirect_url: 'https://staging.wpf.emerchantpay.net/en/payment/9ee21d5a35a3a08615b2082077a5f529' 
  }
  ```
  </details>
  
If an error occurs during the Transaction Execution the status is one of the following:
  * `error`
  * `declined`

<details>
<summary>Example Transaction Execution with Error</summary>

```object
{
  transaction_type: 'authorize3d',
  status: 'declined',
  authorization_code: 671842,
  unique_id: '55b4614e2ffb7677925565431ef83551',
  transaction_id: '57b1b124e68f69212a40390546e59ca2',
  response_code: 1,
  code: 510,
  technical_message: 'card_number is invalid or missing',
  message: 'Credit card number is invalid.',
  mode: 'test',
  timestamp: '2021-07-29T14:30:53Z',
  descriptor: 'test',
  amount: '10.00',
  currency: 'EUR',
  sent_to_acquirer: true
}
```
</details>

#### Failure callback


Upon received status >= 300 from the Gateway or upon invalid request the following JSON object will be received on the failure callback:
```
{
  status: "HTTP Status Code"
  message: "Brief explanation about the error"
  response: {
    // Received Response from the server if there is any
  }
}
```

<details>
<summary>Example Failure Transaction Execution with Response</summary>

```object
{
  status: 401
  message: 'Unauthorized',
  response: {
    status: 'error',
    code: 110,
    technical_message: 'Invalid Authentication',
    message: '401 Unauthorized: Invalid Authentication!'
  }
}
```
</details>

<details>
<summary>Example Failure Transaction Execution without Response</summary>

```object
{ 
  status: 'ENOTFOUND',
  message: 'No response received from hostname: examlpe.com',
  response: undefined
}
```
</details>

Transaction Types
-----------------

```text
account_verification
avs
authorize
authorize3d
blacklist
capture
chargeback
chargeback_by_date
credit
fraud_report
fraud_report_by_date
init_recurring
init_recurring_sale3d
reconcile
reconcile_by_date
recurring_sale
refund
retrieval
retrieval_by_date
payout
sale
sale3d
void
wpf_create
wpf_reconcile
p24
```

Transaction Parameters
----------------------

In order to get a full list of required and optional parameters, please consult our API Documentation.
