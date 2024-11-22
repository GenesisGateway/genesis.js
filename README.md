
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

* File-based configuration

You can override the path to the directory holding your configuration files (by default its ```config``` in the root directory of the module) via environmental variable ```NODE_CONFIG_DIR```. The first file to parse configuration from, is ```<your-config-dir>/default.json``` and based on the environment variable (```NODE_ENV```), you can specify your custom file; for example ```<your-config-dir>/<NODE_ENV_NAME>.json```.

Note: Its good practice to prevent web/direct access to your config directory and protect the files inside

You can override the config inside your code:

- CoffeeScript
  ```coffeescript
  config = require 'config'

  config.customer.token = '<your token>'
  ```
- JavaScript
  ```javascript
  config = require('config')

  config.customer.token = '<your token>'
  ```
  
* Manual 
   
You can set the configuration parameters by creating JSON object and then passing these parameters to the constructor of the Transaction class, as shown below:

- CoffeeScript
```
configuration = {
    customer : 
        "username":            "<enter-your-username>"
        "password"           : "<enter-your-password>"
        "token"              : "<enter-your-token>"
        "force_smart_routing": false
    gateway :
        "protocol" : "https"
        "hostname" : "<please-select-the-endpoint-you-want-e-comprocessing.net-or-emerchantpay.net>"
        "timeout"  : "60000"
        "testing"  : true
    notifications :
        "host"     : "<hostname>"
        "port"     : "<port>",
        "path"     : "<path>"
}

transaction = new genesis.transaction( configuration )
```

- JavaScript
```
configuration = {
    customer : {
        "username":            "<enter-your-username>", 
        "password"           : "<enter-your-password>",
        "token"              : "<enter-your-token>",
        "force_smart_routing": false,
    },
    gateway : {
        "protocol" : "https",
        "hostname" : "<please-select-the-endpoint-you-want-e-comprocessing.net-or-emerchantpay.net>",
        "timeout"  : "60000",
        "testing"  : true
    },
    notifications : {
        "host"     : "<hostname>",
        "port"     : "<port>",
        "path"     : "<path>"
    }
};

transaction = new genesis.transaction configuration 
```
_The minimum required parameters are customer and gateway. Within customer, the mandatory fields are username and password. For gateway, the required fields are hostname and testing.  
If you choose to use file-based configuration instead of a configuration object, you won't need to inject anything into the Transaction class constructor._     

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
      neighborhood: 'Holywood',
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
        first_name   : 'John'
        last_name    : 'Doe'
        address1     : '123 Str.'
        zip_code     : '10000'
        city         : 'New York'
        neighborhood : 'Holywood'
        country      : 'US'
    })
    .send()
    .then(success)
    .catch(failure)
```

The example above is going to create a Sale (Authorize w/ immediate Capture) transaction for the amount of $100.

3DS Transaction
---------------

Sample request including all the conditionally required/optional params for initiating a 3DS transaction with the 3DSv2-Method authentication protocol.

Also, an example is provided for the 3DS-Method-continue API call that will have to be submitted after the 3DS-Method is initiated.

<details>
<summary>JavaScript example</summary>

```js
var crypto, failure, genesis, success, transaction;

genesis        = require('./lib/genesis.js');

crypto = require('crypto');

transaction = new genesis.transaction();

failure = function(reason) {
     return console.log(reason);
};

success = function(data) {
    if (data.status == 'approved') {
      // Transaction approved no customer action required
      // Test Case: Synchronous 3DSv2 Request with Frictionless flow
    }
    
    if (data.status == 'declined' || data.status == 'error') {
      // Transaction declined no customer action required
      // Synchronous 3DSv2 Request with Frictionless flow
    }     
    if (data.status == 'pending_async') {
      if (data.redirect_url) {
          console.log(data.redirect_url_type)
          console.log(data.redirect_url)
      }

      if (data.threeds_method_url) {
          transaction.method_continue(data)
             .send()
             .then(function (data) {
               if (data.status == 'approved') {
                 // Transaction APPROVED no customer action required
                 // Test Case: Asynchronous 3DSv2 Request with 3DS-Method and Frictionless flow
               }
               
               if (data.status == 'pending_async') {
                 // Customer action required
                 if (data.redirect_url) {
                   // Test Case: Asynchronous 3DSv2 Request with 3DS-Method Challenge flow
                   // Test Case: Asynchronous 3DSv2 Request with 3DS-Method Fallback flow
                   console.log(redirect_url_type)
                   console.log(redirect_url)
                 }
               }

               if (data.status == 'declined' || data.status == 'error') {
                 // Transaction declined no customer action required
                 // Synchronous 3DSv2 Request with Frictionless flow
               }   

           })
           .catch(failure);
      }
  }
  return console.log(data);
};

transaction.sale3d({
    transaction_id: 'gnss-js-' + crypto.randomBytes(16).toString('hex'),
    usage: 'Genesis JS Client Automated Request',
    remote_ip: '118.240.158.6',
    currency: 'USD',
    amount: '50',
    // Return URLS
    notification_url: 'http://example.com/',
    return_success_url: 'https://success.ss',
    return_failure_url: 'https://failure.ff',
    // Customer Details
    customer_email: 'email@test.com',
    customer_phone: '0123456789',
    // Credit Card Details
    card_holder: 'Test Tester',
    card_number: '4012000000060085', // Test Case: Synchronous 3DSv2 Request with Frictionless flow
//    Test Cases
//    card_number: '4066330000000004', // Test Case: Asynchronous 3DSv2 Request with 3DS-Method and Frictionless flow
//    card_number: '4918190000000002', // Test Case: Asynchronous 3DSv2 Request with Challenge flow
//    card_number: '4938730000000001', // Test Case: Asynchronous 3DSv2 Request with 3DS-Method Challenge flow
//    card_number: '4901170000000003', // Test Case: Asynchronous 3DSv2 Request with Fallback flow
//    card_number: '4901164281364345', // Test Case: Asynchronous 3DSv2 Request with 3DS-Method Fallback flow
    cvv: '123',
    expiration_month: '01',
    expiration_year: '2020',
    // Billing/Invoice Details
    billing_address: {
        first_name: 'Kamryn',
        last_name: 'Strosin',
        address1: '834 Huels Wells',
        zip_code: '52036-7047',
        city: 'Bettyeview',
        neighborhood: 'Holywood',
        country: 'IQ'
    },
    // 3DSv2 params
    // 3DSv2 Method Attributes
    threeds_v2_params: {
        threeds_method: {
            callback_url: 'https://www.example.com/threeds/threeds_method/callback'
        },
        control: {
            device_type: 'browser',
            challenge_window_size: 'full_screen',
            challenge_indicator: 'preference'
        },
        purchase: {
            category: 'service'
        },
        merchant_risk: {
            shipping_indicator: 'verified_address',
            delivery_timeframe: 'electronic',
            reorder_items_indicator: 'reordered',
            pre_order_purchase_indicator: 'merchandise_available',
            pre_order_date: '19-08-2024',
            gift_card: 'true',
            gift_card_count: 99
        },
        card_holder_account: {
            creation_date: '19-07-2021',
            update_indicator: 'more_than_60days',
            last_change_date: '19-04-2022',
            password_change_indicator: 'no_change',
            password_change_date: '04-07-2022',
            shipping_address_usage_indicator: 'current_transaction',
            shipping_address_date_first_used: '14-07-2022',
            transactions_activity_last_24_hours: 2,
            transactions_activity_previous_year: 10,
            provision_attempts_last_24_hours: 1,
            purchases_count_last_6_months: 5,
            suspicious_activity_indicator: 'no_suspicious_observed',
            registration_indicator: '30_to_60_days',
            registration_date: '19-07-2020'
        },
        browser: {
            accept_header: '*/*',
            java_enabled: false,
            language: 'en-GB',
            color_depth: 32,
            screen_height: 900,
            screen_width: 1440,
            time_zone_offset: '-120',
            user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36'
        },
        sdk: {
            interface: 'native',
            ui_types: {
                ui_type: 'multi_select'
            },
            application_id: 'fc1650c0-5778-0138-8205-2cbc32a32d65',
            encrypted_data: 'encrypted-data-here',
            ephemeral_public_key_pair: 'public-key-pair',
            max_timeout: 10,
            reference_number: 'sdk-reference-number-her'
        }
    }
})
    .send()
    .then(success)
    .catch(failure);
```
</details>

<details>
<summary>CoffeeScript example</summary>

```coffee
genesis = require './lib/genesis.js'

crypto = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->

  if data.status == 'approved' then
      # Transaction approved no customer action required
      # Test Case: Synchronous 3DSv2 Request with Frictionless flow
  
  if data.status == 'declined' || data.status == 'error' then
      # Transaction declined no customer action required
      # Synchronous 3DSv2 Request with Frictionless flow

  if data.status == 'pending_async' then
    if data.redirect_url
      console.log(data.redirect_url_type)
    console.log(data.redirect_url)

  if data.threeds_method_url
     transaction.method_continue(data)
      .send()
      .then data ->
        if data.status == 'approved' then
          # Transaction APPROVED no customer action required
          # Test Case: Asynchronous 3DSv2 Request with 3DS-Method and Frictionless flow
        
          if data.status == 'pending_async'
            # Customer action required
        
          if data.redirect_url
            # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Challenge flow
            # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Fallback flow
            console.log(data.redirect_url_type)
            console.log(data.redirect_url)
        
            if data.status == 'declined' || data.status == 'error' then
              # Transaction declined no customer action required
              # Synchronous 3DSv2 Request with Frictionless flow
      .catch failure

  return console.log(data)

transaction.sale3d({
  transaction_id: 'gnss-js-' + crypto.randomBytes(16).toString('hex')
  usage         : 'Genesis JS Client Automated Request'
  remote_ip     : '118.240.158.6'
  currency      : 'USD'
  amount        : '50'
  # Return URLS
  notification_url  : 'http://example.com/'
  return_success_url: 'https://success.ss'
  return_failure_url: 'https://failure.ff'
  # Customer Details
  customer_email: 'email@test.com'
  customer_phone: '0123456789'
  # Credit Card Details
  card_holder: 'Test Tester'
  card_number: '4012000000060085' # Test Case: Synchronous 3DSv2 Request with Frictionless flow
  # Test Cases
  # card_number: '4066330000000004'   # Test Case: Asynchronous 3DSv2 Request with 3DS-Method and Frictionless flow
  # card_number: '4918190000000002'   # Test Case: Asynchronous 3DSv2 Request with Challenge flow
  # card_number: '4938730000000001'   # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Challenge flow
  # card_number: '4901170000000003'   # Test Case: Asynchronous 3DSv2 Request with Fallback flow
  # card_number: '4901164281364345'   # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Fallback flow
  cvv             : '123'
  expiration_month: '01'
  expiration_year : '2020'
  # Billing/Invoice Details
  billing_address :
    first_name: 'Kamryn'
    last_name : 'Strosin'
    address1  : '834 Huels Wells'
    zip_code  : '52036-7047'
    city      : 'Bettyeview'
    country   : 'IQ'
  # 3DSv2 params
  # 3DSv2 Method Attributes
  threeds_v2_params:
    threeds_method:
      callback_url: 'https://www.example.com/threeds/threeds_method/callback'
    control:
      device_type          : 'browser'
      challenge_window_size: 'full_screen'
      challenge_indicator  : 'preference'
    purchase:
      category: 'service'
    merchant_risk:
      shipping_indicator          : 'verified_address'
      delivery_timeframe          : 'electronic'
      reorder_items_indicator     : 'reordered'
      pre_order_purchase_indicator: 'merchandise_available'
      pre_order_date              : '19-08-2024'
      gift_card                   : 'true'
      gift_card_count             : 99
    card_holder_account:
      creation_date                      : '19-07-2021'
      update_indicator                   : 'more_than_60days'
      last_change_date                   : '19-04-2022'
      password_change_indicator          : 'no_change'
      password_change_date               : '04-07-2022'
      shipping_address_usage_indicator   : 'current_transaction'
      shipping_address_date_first_used   : '14-07-2022'
      transactions_activity_last_24_hours: 2
      transactions_activity_previous_year: 10
      provision_attempts_last_24_hours   : 1
      purchases_count_last_6_months      : 5
      suspicious_activity_indicator      : 'no_suspicious_observed'
      registration_indicator             : '30_to_60_days'
      registration_date                  : '19-07-2020'
    browser:
      accept_header   : '*/*'
      java_enabled    : false
      language        : 'en-GB'
      color_depth     : 32
      screen_height   : 900
      screen_width    : 1440
      time_zone_offset: '-120'
      user_agent      : 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36'
    sdk:
      interface                : 'native'
      ui_types                 :
        ui_type: 'multi_select'
      application_id           : 'fc1650c0-5778-0138-8205-2cbc32a32d65'
      encrypted_data           : 'encrypted-data-here'
      ephemeral_public_key_pair: 'public-key-pair'
      max_timeout              : 10
      reference_number         : 'sdk-reference-number-her'
})
  .send()
  .then(success)
  .catch(failure)
```
</details>

Standalone ThreedsV2 Method Continue Request.

<details>
<summary>JavaScript example</summary>

var failure, genesis, success, transaction;

genesis = require('./lib/genesis.js');

transaction = new genesis.transaction();

failure = function(reason) {
    return console.log(reason);
};

success = function(data) {
    return console.log(data);
};

transaction.method_continue({
    unique_id: 'd6a6aa96292e4856d4a352ce634a4335',
    amount: '60.00',
    currency: 'USD',
    timestamp: '2020-11-10T14:21:37Z'
})
    .send()
    .then(success)
    .catch(failure);
</details>

<details>
<summary>CoffeeScript example</summary>

genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->
  console.log data
  
transaction.method_continue({
    unique_id: 'd6a6aa96292e4856d4a352ce634a4335'
    amount   : '60.00'
    currency : 'USD'
    timestamp: '2020-11-10T14:21:37Z'
})
    .send()
    .then(success)
    .catch(failure);  
  
</details>


Google Pay Transaction
----------------------------

Processing

<details>
<summary>JavaScript example</summary>

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

payment_token = {"protocolVersion":"ECv2","signature":"MEQCIH6Q4OwQ0jAceFEkGF0JID6sJNXxOEi4r+mA7biRxqBQAiAondqoUpU/bdsrAOpZIsrHQS9nwiiNwOrr24RyPeHA0Q\u003d\u003d","intermediateSigningKey":{"signedKey": "{\"keyExpiration\":\"1542323393147\",\"keyValue\":\"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE/1+3HBVSbdv+j7NaArdgMyoSAM43yRydzqdg1TxodSzA96Dj4Mc1EiKroxxunavVIvdxGnJeFViTzFvzFRxyCw\\u003d\\u003d\"}","signatures": ["MEYCIQCO2EIi48s8VTH+ilMEpoXLFfkxAwHjfPSCVED/QDSHmQIhALLJmrUlNAY8hDQRV/y1iKZGsWpeNmIP+z+tCQHQxP0v"]}, "signedMessage":"{\"tag\":\"jpGz1F1Bcoi/fCNxI9n7Qrsw7i7KHrGtTf3NrRclt+U\\u003d\",\"ephemeralPublicKey\":\"BJatyFvFPPD21l8/uLP46Ta1hsKHndf8Z+tAgk+DEPQgYTkhHy19cF3h/bXs0tWTmZtnNm+vlVrKbRU9K8+7cZs\\u003d\",\"encryptedMessage\":\"mKOoXwi8OavZ\"}"}

transaction.google_pay({
    transaction_id: crypto.randomBytes(16).toString('hex'),
    usage: 'Demo Authorize Transaction',
    payment_subtype: 'sale',
    payment_token: payment_token,
    amount: '100',
    currency: 'USD',
    customer_email: 'email@test.com',
    customer_phone: '0123456789',
    remote_ip: '245.253.2.12',
    birth_date: '12-12-2008',
    billing_address: {
        first_name: 'John',
        last_name: 'Doe',
        address1: '123 Str.',
        zip_code: '10000',
        city: 'New York',
        neighborhood: 'Holywood',
        country: 'US'
    },
    shipping_address: {
        first_name: 'John',
        last_name: 'Doe',
        address1: '123 Str.',
        zip_code: '10000',
        city: 'New York',
        neighborhood: 'Holywood',
        country: 'US'
    },
    notification_url: 'http://my.host.name.tld:1234/notifier',
    return_success_url: 'http://my.host.name.tld/success',
    return_failure_url: 'http://my.host.name.tld/failure',
})
    .send()
    .then(success)
    .catch(failure);
```
</details>

<details>
<summary>CoffeeScript example</summary>

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->
  console.log data

payment_token = {"protocolVersion":"ECv2","signature":"MEQCIH6Q4OwQ0jAceFEkGF0JID6sJNXxOEi4r+mA7biRxqBQAiAondqoUpU/bdsrAOpZIsrHQS9nwiiNwOrr24RyPeHA0Q\u003d\u003d","intermediateSigningKey":{"signedKey": "{\"keyExpiration\":\"1542323393147\",\"keyValue\":\"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE/1+3HBVSbdv+j7NaArdgMyoSAM43yRydzqdg1TxodSzA96Dj4Mc1EiKroxxunavVIvdxGnJeFViTzFvzFRxyCw\\u003d\\u003d\"}","signatures": ["MEYCIQCO2EIi48s8VTH+ilMEpoXLFfkxAwHjfPSCVED/QDSHmQIhALLJmrUlNAY8hDQRV/y1iKZGsWpeNmIP+z+tCQHQxP0v"]}, "signedMessage":"{\"tag\":\"jpGz1F1Bcoi/fCNxI9n7Qrsw7i7KHrGtTf3NrRclt+U\\u003d\",\"ephemeralPublicKey\":\"BJatyFvFPPD21l8/uLP46Ta1hsKHndf8Z+tAgk+DEPQgYTkhHy19cF3h/bXs0tWTmZtnNm+vlVrKbRU9K8+7cZs\\u003d\",\"encryptedMessage\":\"mKOoXwi8OavZ\"}"}

transaction.google_pay({
  transaction_id           : crypto.randomBytes(16).toString('hex')
  usage                    : 'Demo Authorize Transaction',
  payment_subtype          : 'sale',
  payment_token            : payment_token,
  amount                   : '100',
  currency                 : 'USD',
  customer_email           : 'email@test.com',
  customer_phone           : '0123456789',
  remote_ip                : '245.253.2.12',
  birth_date               : '12-12-2008',
  billing_address          :
    first_name: 'John',
    last_name : 'Doe',
    address1  : '123 Str.',
    zip_code  : '10000',
    city      : 'New York',
    country   : 'US'
  shipping_address         :
    first_name   : 'John',
    last_name    : 'Doe',
    address1     : '123 Str.',
    zip_code     : '10000',
    city         : 'New York',
    neighborhood : 'Holywood',
    country      : 'US'
  notification_url  : 'http://my.host.name.tld:1234/notifier',
  return_success_url: 'http://my.host.name.tld/success',
  return_failure_url: 'http://my.host.name.tld/failure',
})
  .send()
  .then(success)
  .catch(failure)

```
</details>

WPF

<details>
<summary>JavaScript example</summary>

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
    transaction_id: crypto.randomBytes(16).toString('hex'),
    transaction_types: [
        {
            'google_pay' : {
                payment_subtype: 'sale'
            }

        }
    ],
    usage: 'Genesis JS Client Automated Request',
    currency: 'EUR',
    amount: '100',
    customer_email: 'Clotilde_Hettinger54@hotmail.com',
    customer_phone: '1-749-394-9321 x93370',
    notification_url: 'http://my.host.name.tld:1234/notifier',
    return_success_url: 'http://my.host.name.tld/success',
    return_failure_url: 'http://my.host.name.tld/failure',
    return_cancel_url: 'http://my.host.name.tld/cancel'
})
    .send()
    .then(success)
    .catch(failure);

```
</details>

<details>
<summary>CoffeeScript example</summary>

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->
  console.log data

transaction.wpf_create({
  transaction_id     : crypto.randomBytes(16).toString('hex'),
  transaction_types  : [
    'google_pay' :
      payment_subtype: 'sale'
  ],
  usage             : 'Demo WPF Transaction'
  description       : 'This is my first WPF transaction'
  amount            : '100'
  currency          : 'USD'
  customer_email    : 'email@example.com'
  customer_phone    : '0123456789'
  notification_url  : 'http://my.host.name.tld:1234/notifier'
  return_success_url: 'http://my.host.name.tld/success'
  return_failure_url: 'http://my.host.name.tld/failure'
  return_cancel_url : 'http://my.host.name.tld/cancel'
})
 .send()
  .then(success)
  .catch(failure);
```

</details>

Apple Pay Transaction
----------------------------

Processing

<details>
<summary>JavaScript example</summary>

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

payment_token = {"paymentData":{"version": "EC_v1","data": "nvV/CyVrVC1jC3nvoYTmw/APqMS3jSdM4/sIoCbnHiqhCWtpVkEWrAkxGqjp1lryX7wtTn07Om7TGyxztYK/KPQM6ajHXDsIpGWUtDAuVFCqzTNWYUukpjkF5cokLPm+0oc1lwDFKLIexW0QmIyKj4WUS3hIyI10zdMAzNCU5BKDto21eVqQaYWyPYDkoAafrIwpYnCUoWFWCQ91Gj0xnIVK9ElaWepAMp6iAXm5DzR+N0A6AwCtxp3AXhP/2A+nTNvemO7eFfkNMaW/yIYPHD+GRDq3gp5yvVNVDzLvAYPoR8iCGuF3YA21sh7Ewoj7M7QO1tSjcPympazC+QUuKl9XQSUXayOrqka6vEbc1ZifotmjKvvmc3nTDaOPoTAPSG+ymBS9EUcd+65/CrdZF4Rdb5vyZEylqB45p3o=","signature": "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","header":{            "ephemeralPublicKey": "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE0Qgk5F6L0FCO1H34M4DLB6yDRHs3k0NeJUgtiQ66ZYBa4RCjlkhFPy63vSCGmeZ9Q19oWDOYSwA9Z3fnYslZCg==","publicKeyHash":"QOmvMaoCNYk5tv+69KC1i2UCFQcOl6LYPIJfYAT+SLQ=","transactionId": "cd9a7d0da9bbca9c87490e5eaeb7d4080c9ab80528248fc3cb70aa3fe47c36cd"}},"paymentMethod":{"displayName":"Visa 0225","network":"Visa","type":"debit"},"transactionIdentifier":"CD9A7D0DA9BBCA9C87490E5EAEB7D4080C9AB80528248FC3CB70AA3FE47C36CD"};

transaction.apple_pay({
  transaction_id: crypto.randomBytes(16).toString('hex'),
  usage: 'Demo Authorize Transaction',
  payment_subtype: 'sale',
  payment_token: payment_token,
  amount: '100',
  currency: 'USD',
  customer_email: 'email@test.com',
  customer_phone: '0123456789',
  remote_ip: '245.253.2.12',
  birth_date: '12-12-2008',
  billing_address: {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'US'
  },
  shipping_address: {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'US'
  }
})
.send()
.then(success)
.catch(failure)
```

</details>

<details>
<summary>CoffeeScript example</summary>

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->
  console.log data

payment_token = {"paymentData":{"version": "EC_v1","data": "nvV/CyVrVC1jC3nvoYTmw/APqMS3jSdM4/sIoCbnHiqhCWtpVkEWrAkxGqjp1lryX7wtTn07Om7TGyxztYK/KPQM6ajHXDsIpGWUtDAuVFCqzTNWYUukpjkF5cokLPm+0oc1lwDFKLIexW0QmIyKj4WUS3hIyI10zdMAzNCU5BKDto21eVqQaYWyPYDkoAafrIwpYnCUoWFWCQ91Gj0xnIVK9ElaWepAMp6iAXm5DzR+N0A6AwCtxp3AXhP/2A+nTNvemO7eFfkNMaW/yIYPHD+GRDq3gp5yvVNVDzLvAYPoR8iCGuF3YA21sh7Ewoj7M7QO1tSjcPympazC+QUuKl9XQSUXayOrqka6vEbc1ZifotmjKvvmc3nTDaOPoTAPSG+ymBS9EUcd+65/CrdZF4Rdb5vyZEylqB45p3o=","signature": "MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIID4zCCA4igAwIBAgIITDBBSVGdVDYwCgYIKoZIzj0EAwIwejEuMCwGA1UEAwwlQXBwbGUgQXBwbGljYXRpb24gSW50ZWdyYXRpb24gQ0EgLSBHMzEmMCQGA1UECwwdQXBwbGUgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxEzARBgNVBAoMCkFwcGxlIEluYy4xCzAJBgNVBAYTAlVTMB4XDTE5MDUxODAxMzI1N1oXDTI0MDUxNjAxMzI1N1owXzElMCMGA1UEAwwcZWNjLXNtcC1icm9rZXItc2lnbl9VQzQtUFJPRDEUMBIGA1UECwwLaU9TIFN5c3RlbXMxEzARBgNVBAoMCkFwcGxlIEluYy4xCzAJBgNVBAYTAlVTMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEwhV37evWx7Ihj2jdcJChIY3HsL1vLCg9hGCV2Ur0pUEbg0IO2BHzQH6DMx8cVMP36zIg1rrV1O/0komJPnwPE6OCAhEwggINMAwGA1UdEwEB/wQCMAAwHwYDVR0jBBgwFoAUI/JJxE+T5O8n5sT2KGw/orv9LkswRQYIKwYBBQUHAQEEOTA3MDUGCCsGAQUFBzABhilodHRwOi8vb2NzcC5hcHBsZS5jb20vb2NzcDA0LWFwcGxlYWljYTMwMjCCAR0GA1UdIASCARQwggEQMIIBDAYJKoZIhvdjZAUBMIH+MIHDBggrBgEFBQcCAjCBtgyBs1JlbGlhbmNlIG9uIHRoaXMgY2VydGlmaWNhdGUgYnkgYW55IHBhcnR5IGFzc3VtZXMgYWNjZXB0YW5jZSBvZiB0aGUgdGhlbiBhcHBsaWNhYmxlIHN0YW5kYXJkIHRlcm1zIGFuZCBjb25kaXRpb25zIG9mIHVzZSwgY2VydGlmaWNhdGUgcG9saWN5IGFuZCBjZXJ0aWZpY2F0aW9uIHByYWN0aWNlIHN0YXRlbWVudHMuMDYGCCsGAQUFBwIBFipodHRwOi8vd3d3LmFwcGxlLmNvbS9jZXJ0aWZpY2F0ZWF1dGhvcml0eS8wNAYDVR0fBC0wKzApoCegJYYjaHR0cDovL2NybC5hcHBsZS5jb20vYXBwbGVhaWNhMy5jcmwwHQYDVR0OBBYEFJRX22/VdIGGiYl2L35XhQfnm1gkMA4GA1UdDwEB/wQEAwIHgDAPBgkqhkiG92NkBh0EAgUAMAoGCCqGSM49BAMCA0kAMEYCIQC+CVcf5x4ec1tV5a+stMcv60RfMBhSIsclEAK2Hr1vVQIhANGLNQpd1t1usXRgNbEess6Hz6Pmr2y9g4CJDcgs3apjMIIC7jCCAnWgAwIBAgIISW0vvzqY2pcwCgYIKoZIzj0EAwIwZzEbMBkGA1UEAwwSQXBwbGUgUm9vdCBDQSAtIEczMSYwJAYDVQQLDB1BcHBsZSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTETMBEGA1UECgwKQXBwbGUgSW5jLjELMAkGA1UEBhMCVVMwHhcNMTQwNTA2MjM0NjMwWhcNMjkwNTA2MjM0NjMwWjB6MS4wLAYDVQQDDCVBcHBsZSBBcHBsaWNhdGlvbiBJbnRlZ3JhdGlvbiBDQSAtIEczMSYwJAYDVQQLDB1BcHBsZSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTETMBEGA1UECgwKQXBwbGUgSW5jLjELMAkGA1UEBhMCVVMwWTATBgcqhkjOPQIBBggqhkjOPQMBBwNCAATwFxGEGddkhdUaXiWBB3bogKLv3nuuTeCN/EuT4TNW1WZbNa4i0Jd2DSJOe7oI/XYXzojLdrtmcL7I6CmE/1RFo4H3MIH0MEYGCCsGAQUFBwEBBDowODA2BggrBgEFBQcwAYYqaHR0cDovL29jc3AuYXBwbGUuY29tL29jc3AwNC1hcHBsZXJvb3RjYWczMB0GA1UdDgQWBBQj8knET5Pk7yfmxPYobD+iu/0uSzAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFLuw3qFYM4iapIqZ3r6966/ayySrMDcGA1UdHwQwMC4wLKAqoCiGJmh0dHA6Ly9jcmwuYXBwbGUuY29tL2FwcGxlcm9vdGNhZzMuY3JsMA4GA1UdDwEB/wQEAwIBBjAQBgoqhkiG92NkBgIOBAIFADAKBggqhkjOPQQDAgNnADBkAjA6z3KDURaZsYb7NcNWymK/9Bft2Q91TaKOvvGcgV5Ct4n4mPebWZ+Y1UENj53pwv4CMDIt1UQhsKMFd2xd8zg7kGf9F3wsIW2WT8ZyaYISb1T4en0bmcubCYkhYQaZDwmSHQAAMYIBjDCCAYgCAQEwgYYwejEuMCwGA1UEAwwlQXBwbGUgQXBwbGljYXRpb24gSW50ZWdyYXRpb24gQ0EgLSBHMzEmMCQGA1UECwwdQXBwbGUgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxEzARBgNVBAoMCkFwcGxlIEluYy4xCzAJBgNVBAYTAlVTAghMMEFJUZ1UNjANBglghkgBZQMEAgEFAKCBlTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMjUxMjEwMTJaMCoGCSqGSIb3DQEJNDEdMBswDQYJYIZIAWUDBAIBBQChCgYIKoZIzj0EAwIwLwYJKoZIhvcNAQkEMSIEIFcZYehkQATlRzP9tXFgYFWFWTiqNvRIhLctoHgl6Gw2MAoGCCqGSM49BAMCBEcwRQIhAIYWIkG4d1mM/bYPtLMHgsLVzCeH7ZDBq8lj5TJ7RXwUAiB/cpwIxwEiACEHdxtp62mkI+B9gFL+WPMf0tlMeCTGuAAAAAAAAA==","header":{            "ephemeralPublicKey": "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE0Qgk5F6L0FCO1H34M4DLB6yDRHs3k0NeJUgtiQ66ZYBa4RCjlkhFPy63vSCGmeZ9Q19oWDOYSwA9Z3fnYslZCg==","publicKeyHash":"QOmvMaoCNYk5tv+69KC1i2UCFQcOl6LYPIJfYAT+SLQ=","transactionId": "cd9a7d0da9bbca9c87490e5eaeb7d4080c9ab80528248fc3cb70aa3fe47c36cd"}},"paymentMethod":{"displayName":"Visa 0225","network":"Visa","type":"debit"},"transactionIdentifier":"CD9A7D0DA9BBCA9C87490E5EAEB7D4080C9AB80528248FC3CB70AA3FE47C36CD"}

transaction.apple_pay({
  transaction_id : crypto.randomBytes(16).toString('hex')
  usage          : 'Demo Authorize Transaction'
  payment_subtype: 'sale'
  payment_token  : payment_token
  amount         : '100'
  currency       : 'USD'
  customer_email : 'email@test.com'
  customer_phone : '0123456789'
  remote_ip      : '245.253.2.12'
  birth_date     : '12-12-2008'
  billing_address: {
    first_name: 'John'
    last_name : 'Doe'
    address1  : '123 Str.'
    zip_code  : '10000'
    city      : 'New York'
    country   : 'US'
  },
  shipping_address: {
    first_name: 'John'
    last_name : 'Doe'
    address1  : '123 Str.'
    zip_code  : '10000'
    city      : 'New Yok'
    country   : 'US'
  }
})
  .send()
  .then(success)
  .catch(failure)
```

</details>

WPF

<details>
<summary>JavaScript example</summary>

```js
var crypto, failure, genesis, success, transaction;

genesis = require('.lib/genesis.js');

crypto = require('crypto');

transaction = new genesis.transaction();

failure = function(reason) {
    return console.log(reason);
};

success = function(data) {
    return console.log(data);
};

transaction.wpf_create({
    transaction_id: crypto.randomBytes(16).toString('hex'),
    transaction_types: [
        {
            'apple_pay' : {
                payment_subtype: 'sale'
            }

        }
    ],
    usage: 'Genesis JS Client Automated Request',
    currency: 'EUR',
    amount: '100',
    customer_email: 'Clotilde_Hettinger54@hotmail.com',
    customer_phone: '1-749-394-9321 x93370',
    notification_url: 'http://my.host.name.tld:1234/notifier',
    return_success_url: 'http://my.host.name.tld/success',
    return_failure_url: 'http://my.host.name.tld/failure',
    return_cancel_url: 'http://my.host.name.tld/cancel'
})
    .send()
    .then(success)
    .catch(failure);

```

</details>

<details>
<summary>CoffeeScript example</summary>

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->
  console.log data

transaction.wpf_create({
  transaction_id     : crypto.randomBytes(16).toString('hex')
  transaction_types  : [
    'apple_pay' :
      payment_subtype: 'sale'
  ],
  usage             : 'Demo WPF Transaction'
  description       : 'This is my first WPF transaction'
  amount            : '100'
  currency          : 'USD'
  customer_email    : 'email@example.com'
  customer_phone    : '0123456789'
  notification_url  : 'http://my.host.name.tld:1234/notifier'
  return_success_url: 'http://my.host.name.tld/success'
  return_failure_url: 'http://my.host.name.tld/failure'
  return_cancel_url : 'http://my.host.name.tld/cancel'
})
  .send()
  .then(success)
  .catch(failure);

```

</details>

PayPal Transaction
----------------------------

Processing

<details>
<summary>JavaScript example</summary>

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

transaction.pay_pal({
    transaction_id : crypto.randomBytes(16).toString('hex'),
    usage          : 'Demo Authorize Transaction',
    payment_type   : 'sale',
    amount         : '100',
    currency       : 'USD',
    customer_email : 'email@test.com',
    customer_phone : '0123456789',
    remote_ip      : '245.253.2.12',
    birth_date     : '12-12-2008',
    billing_address: {
      first_name   : 'John',
      last_name    : 'Doe',
      address1     : '123 Str.',
      zip_code     : '10000',
      city         : 'New York',
      neighborhood : 'Holywood',
      country      : 'US'
    },
    shipping_address: {
      first_name   : 'John',
      last_name    : 'Doe',
      address1     : '123 Str.',
      zip_code     : '10000',
      city         : 'New Yok',
      neighborhood : 'Holywood',
      country      : 'US',
    },
    notification_url   : 'http://my.host.name.tld/notification',
    return_success_url : 'http://my.host.name.tld/success',
    return_failure_url : 'http://my.host.name.tld/failure',
    return_cancel_url  : 'http://my.host.name.tld/cancel',
    return_pending_url : 'http://my.host.name.tld/pending'
})
  .send()
  .then(success)
  .catch(failure)
```
</details>

<details>
<summary>CoffeeScript example</summary>

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->
  console.log data

transaction.pay_pal({
  transaction_id : crypto.randomBytes(16).toString('hex')
  usage          : 'Demo Authorize Transaction'
  payment_type   : 'sale'
  amount         : '100'
  currency       : 'USD'
  customer_email : 'email@test.com'
  customer_phone : '0123456789'
  remote_ip      : '245.253.2.12'
  birth_date     : '12-12-2008'
  billing_address:
    first_name   : 'John'
    last_name    : 'Doe'
    address1     : '123 Str.'
    zip_code     : '10000'
    city         : 'New York'
    neighborhood : 'Holywood',
    country      : 'US'
  shipping_address:
    first_name   : 'John'
    last_name    : 'Doe'
    address1     : '123 Str.'
    zip_code     : '10000'
    city         : 'New Yok'
    neighborhood : 'Holywood',
    country      : 'US'
  notification_url   : 'http://my.host.name.tld/notification',
  return_success_url : 'http://my.host.name.tld/success',
  return_failure_url : 'http://my.host.name.tld/failure',
  return_cancel_url  : 'http://my.host.name.tld/cancel',
  return_pending_url : 'http://my.host.name.tld/pending'
})
  .send()
  .then(success)
  .catch(failure)

```
</details>

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
      neighborhood: 'Holywood',
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
        first_name   : 'John'
        last_name    : 'Doe'
        address1     : '123 Str.'
        zip_code     : '10000'
        city         : 'New York'
        neighborhood : 'Holywood',
        country      : 'US'
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

Web Payment Form Transaction with custom attributes in transaction types
----------------------------

- JavaScript

```js


transaction.wpf_create({
    locale: 'en',
    transaction_id: crypto.randomBytes(16).toString('hex'),
    usage: 'Demo WPF Transaction',
    description: 'This is my first WPF transaction',
    remote_ip: '127.0.0.1',
    amount: '100',
    currency: 'EUR',
    // Customer Details
    customer_email: 'email@example.com',
    customer_phone: '0123456789',
    notification_url: 'http://my.host.name.tld:1234/notifier',
    return_success_url: 'http://my.host.name.tld/success',
    return_failure_url: 'http://my.host.name.tld/failure',
    return_cancel_url: 'http://my.host.name.tld/cancel',
    // Billing/Invoice Details
    billing_address: {
        first_name: 'John',
        last_name: 'Doe',
        address1: '123 Str.',
        zip_code: '10000',
        city: 'New York',
        neighborhood: 'Holywood',
        country: 'US',
        state: 'California'
    },
    transaction_types: [
        // Authorize
        {
            authorize: {
                // custom attributes bellow aren`t required
                bin: '111111',
                tail: '0000',
                expiration_date: '2020-10'
            }
        },
        // Sale
        {
            sale: {
                // custom attributes bellow aren`t required
                bin: '111',
                tail: '000',
                crypto: 'true',
                fx_rate_id: '123',
            }
        },
        // Trusly Sale
        // Transaction type requires user_id as shown below
        {
            trustly_sale: {
                // return_success_url_target is required for trusly_sale
                return_success_url_target: 'top'
            }
        }
    ],
    user_id: '123456', // Required when trustly_sale transaction type is used
    customer_account_id: 123456,
    payment_method: "eps"
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
        first_name   : 'John'
        last_name    : 'Doe'
        address1     : '123 Str.'
        zip_code     : '10000'
        city         : 'New York'
        neighborhood : 'Holywood',
        country      : 'US'
        state        : 'California'
    transaction_types: [
        # Authorize
        authorize:
            # custom attributes bellow are not required
            bin: '111111',
            tail: '0000',
            expiration_date: '2020-10'
        # Sale
        sale:
            # custom attributes bellow are not required
            bin: '111',
            tail: '000',
            crypto: 'true',
            fx_rate_id: '123',
        # Trusly Sale
        # Transaction type requires user_id as shown below
        trustly_sale:
            # return_success_url_target is required for trusly_sale
            return_success_url_target: 'top'
    ]
})
.send()
.then(success)
.catch(failure)
```
Web Payment Form Transaction with business_attributes 
----------------------------

- Javascript

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
    locale: 'en',
    transaction_id: crypto.randomBytes(16).toString('hex'),
    usage: 'Demo WPF Transaction',
    description: 'This is my first WPF transaction',
    remote_ip: '127.0.0.1',
    amount: '100',
    currency: 'EUR',
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
        neighborhood: 'Holywood',
        country: 'US',
        state: 'California'
    },
    transaction_types: ['authorize', 'sale3d'],
    customer_account_id: 11111,

    // Full list of business attributes
    business_attributes: {
        // Airlines Air Carriers
        flight_arrival_date: '31-12-2021',
        airline_code: '1111',
        flight_ticket_number: '123456789',
        flight_origin_city: 'Sofia',
        flight_destination_city: 'Berlin',
        airline_tour_operator_name: 'Test',

        // Event Management
        event_start_date: '12-10-2021',
        event_end_date: '01-10-2021',
        event_organizer_id: '11111',
        event_id: '321',

        // Furniture
        date_of_order: '12-10-2020',
        delivery_date: '31-12-2020',
        name_of_the_supplier: 'Supplier',

        // Hotels and Real estate rentals
        check_in_date: '12-10-2020',
        check_out_date: '16-10-2020',
        travel_agency_name: 'test',

        // Car, Plane and Boat Rentals
        vehicle_pick_up_date: '11-10-2020',
        vehicle_return_date: '12-10-2020',
        supplier_name: 'Rent a car',

        // Cruise Lines
        cruise_start_date: '12-10-2020',
        cruise_end_date: '12-11-2020',

        // Travel Agencies
        arrival_date: '12-12-2020',
        departure_date: '13-12-2020',
        carrier_code: '333',
        flight_number: '32',
        ticket_number: '111111111111',
        origin_city: 'Berlin',
        destination_city: 'Sofia',
        travel_agency: 'Agency',
        contractor_name: 'Contractor',
        atol_certificate: '123456',
        pick_up_date: '12-10-2020',
        return_date: '13-10-2020',

        // Common
        payment_type: 'deposit' // deposit or balance
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
      first_name   : 'John'
      last_name    : 'Doe'
      address1     : '123 Str.'
      zip_code     : '10000'
      city         : 'New York'
      neighborhood : 'Holywood',
      country      : 'US'
      state        : 'California'
    transaction_types: ['authorize', 'sale3d']

    # Full list of business attributes
    business_attributes:
      # Airlines Air Carriers
      flight_arrival_date: '31-12-2021',
      airline_code: '1111',
      flight_ticket_number: '123456789',
      flight_origin_city: 'Sofia',
      flight_destination_city: 'Berlin',
      airline_tour_operator_name: 'Test',

      # Event Management
      event_start_date: '12-10-2021',
      event_end_date: '01-10-2021',
      event_organizer_id: '11111',
      event_id: '321',

      # Furniture
      date_of_order: '12-10-2020',
      delivery_date: '31-12-2020',
      name_of_the_supplier: 'Supplier',

      # Hotels and Real estate rentals
      check_in_date: '12-10-2020',
      check_out_date: '16-10-2020',
      travel_agency_name: 'test',

      # Car, Plane and Boat Rentals
      vehicle_pick_up_date: '11-10-2020',
      vehicle_return_date: '12-10-2020',
      supplier_name: 'Rent a car',

      # Cruise Lines
      cruise_start_date: '12-10-2020',
      cruise_end_date: '12-11-2020',

      # Travel Agencies
      arrival_date: '12-12-2020',
      departure_date: '13-12-2020',
      carrier_code: '333',
      flight_number: '32',
      ticket_number: '111111111111',
      origin_city: 'Berlin',
      destination_city: 'Sofia',
      travel_agency: 'Agency',
      contractor_name: 'Contractor',
      atol_certificate: '123456',
      pick_up_date: '12-10-2020',
      return_date: '13-10-2020',

      # Common
      payment_type: 'deposit' # deposit or balance
})
.send()
.then(success)
.catch(failure)
```
Web Payment Form Transaction with managed_recurring 
----------------------------

- Javascript

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
        neighborhood: 'Holywood',
        country: 'US'
    },
    shipping_address: {
        first_name: 'John',
        last_name: 'Doe',
        address1: '123 Str.',
        zip_code: '10000',
        city: 'New York',
        neighborhood: 'Holywood',
        country: 'US'
    },
    transaction_types: [
        {
          init_recurring_sale: {
            managed_recurring: {
              mode: "automatic",
              interval: "days",
              first_date: "2023-12-18",
              time_of_day: 5,
              period: 22,
              amount: 500,
              max_count: 10
            }
          },
        }
    ]
})
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

transaction.wpf_create({
    locale            : 'de'
    transaction_id    : crypto.randomBytes(16).toString('hex')
    usage             : 'Demo WPF Transaction'
    description       : 'This is my first WPF transaction'
    amount            : '100'
    currency          : 'USD'
    customer_email    : 'email@example.com'
    customer_phone    : '0123456789'
    notification_url  : 'http://my.host.name.tld:1234/notifier'
    return_success_url: 'http://my.host.name.tld/success'
    return_failure_url: 'http://my.host.name.tld/failure'
    return_cancel_url : 'http://my.host.name.tld/cancel'
    billing_address   :
      first_name   : 'John'
      last_name    : 'Doe'
      address1     : '123 Str.'
      zip_code     : '10000'
      city         : 'New York'
      neighborhood : 'Holywood',
      country      : 'US'
      state        : 'CA'
    shipping_address:
      first_name   : 'John'
      last_name    : 'Doe'
      address1     : '123 Str.'
      zip_code     : '10000'
      city         : 'New York'
      neighborhood : 'Holywood',
      country      : 'US'
    transaction_types: [
      init_recurring_sale:
        managed_recurring:
          mode: "automatic"
          interval: "days"
          first_date: "2023-12-18"
          time_of_day: 5
          period: 22
          amount: 500
          max_count: 10
    ],
})
.send()
.then(success)
.catch(failure)
```

The example above is going to create a new ```WPF``` with ```Init Recurring Sale``` transaction with ```managed_recurring``` attributes.

Travel Data Attributes
-------------------------

Level 3 travel data is supplied as optional data to the standard API request. If the supplied is valid travel data then the transaction will be processed as a travel transaction and will qualify for the travel Incentive rates. Otherwise the transaction will be processed normally as a regular transaction. Note that the travel data will be stored as part of the transaction in all cases.

Travel data is supported for Authorize, Authorize3D, Capture, Sale, Sale3D, InitRecurringSale, InitRecurringSale3D, RecurringSale.
<details>
  <summary>Details</summary>

```
travel: {
  ticket: {
    ticket_number: '12345',
    passenger_name: 'John Smith',
    customer_code: '1',
    restricted_ticket_indicator: 1,
    agency_name: 'Agency',
    agency_code: 'AG001',
    confirmation_information: 'Confirmation',
    date_of_issue: '2018-02-01'
  },
  rentals: {
    car_rental: {
      purchase_identifier: 12478,
      class_id: 3,
      pickup_date: '2018-02-05',
      renter_name: 'John Smith Example',
      return_city: 'Varna',
      return_state: 'VAR',
      return_country: 'BGR',
      return_date: '2018-02-06',
      renter_return_location_id: 12478,
      customer_code: 1
    },
    hotel_rental: {
      purchase_identifier: 12478,
      arrival_date: 3,
      departure_date: '2018-02-05',
      customer_code: 1
    }
  },
  charges: {
    charge: {
      type: 'MISC'
    }
  },
  legs: [
    {
      departure_date: '2018-02-01',
      carrier_code: '2' ,
      service_class: '3',
      origin_city: 'SOF',
      destination_city: 'VAR',
      stopover_code: '1',
      fare_basis_code: '1',
      flight_number: 'W6666'
    },
    {
      departure_date: '2018-02-01',
      carrier_code: 2,
      service_class: 3,
      origin_city: 'VAR',
      destination_city: 'FRA',
      stopover_code: 0,
      fare_basis_code: 1,
      flight_number: 'W6366'
    }
  ],
  taxes: [
    {
      fee_amount: 1000,
      fee_type: 'Airport tax'
    },
    {
      fee_amount: 1000,
      fee_type: 'Airport tax'
    }
  ]
}
```
</details>
  

Web Payment Form Transaction with pay_later attributes
----------------------------

The Pay Later functionality in the WPF form provides the ability to choose whether the customer would have the option enabled to delay the payment and complete it later. It also gives the ability to enqueue reminders based on pre-configured values. The reminders include the URL for payment completion as well.

Reminders configuration
Up to 3 reminders can be configured for each payment.
 - The available channels for sending reminders are email and sms.
 - The time for sending a reminder is set in number of minutes after payment creation.
 - The time for sending of each reminder shouldn't be greater that the configured payment lifetime.

- Javascript

<details>
<summary>Details</summary>

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
        neighborhood: 'Holywood',
        country: 'US'
    },
    shipping_address: {
        first_name: 'John',
        last_name: 'Doe',
        address1: '123 Str.',
        zip_code: '10000',
        city: 'New York',
        neighborhood: 'Holywood',
        country: 'US'
    },
    transaction_types: [sale],
    pay_later: true,
    reminder_language: 'en',
    reminders: [
      {
        channel: 'email',
        after: 40
      },
      {
        channel: 'sms',
        after: 10
      }
    ]
})
```
</details>

- CoffeeScript

<details>
<summary>Details</summary>

```coffee
genesis = require './lib/genesis.js'
crypto  = require 'crypto'

transaction = new genesis.transaction();

failure = (reason) ->
  console.log reason

success = (data) ->
  console.log data

transaction.wpf_create({
    locale            : 'de'
    transaction_id    : crypto.randomBytes(16).toString('hex')
    usage             : 'Demo WPF Transaction'
    description       : 'This is my first WPF transaction'
    amount            : '100'
    currency          : 'USD'
    customer_email    : 'email@example.com'
    customer_phone    : '0123456789'
    notification_url  : 'http://my.host.name.tld:1234/notifier'
    return_success_url: 'http://my.host.name.tld/success'
    return_failure_url: 'http://my.host.name.tld/failure'
    return_cancel_url : 'http://my.host.name.tld/cancel'
    billing_address   :
      first_name   : 'John'
      last_name    : 'Doe'
      address1     : '123 Str.'
      zip_code     : '10000'
      city         : 'New York'
      neighborhood : 'Holywood',
      country      : 'US'
      state        : 'CA'
    shipping_address:
      first_name: 'John'
      last_name: 'Doe'
      address1: '123 Str.'
      zip_code: '10000'
      city: 'New York'
      neighborhood: 'Holywood',
      country: 'US'
    transaction_types: ['sale'],
    pay_later: true,
    reminder_language: 'en',
    reminders: [
      {
        channel: 'email',
        after: 40
      },
      {
        channel: 'sms',
        after: 10
      }
    ]
  })
.send()
.then(success)
.catch(failure)
```
</details>


Notification Listener
---------------------

- JavaScript

```js
var success, failure, genesis, notification, notification_url;

genesis = require('./lib/genesis.js');

configuration = {
    customer : {
        "username":            "<enter-your-username>", 
        "password"           : "<enter-your-password>",
    },
    gateway : {
        "hostname" : "<please-select-the-endpoint-you-want-e-comprocessing.net-or-emerchantpay.net>",
        "testing"  : true,
    }
};

notification = new genesis.notification(configuration);

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

genesis = require('./lib/genesis.js');

configuration = {
    customer :
        "username":            "<enter-your-username>", 
        "password"           : "<enter-your-password>"
    gateway : 
        "hostname" : "<please-select-the-endpoint-you-want-e-comprocessing.net-or-emerchantpay.net>",
        "testing"  : true
};

notification = new genesis.notification(configuration)

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
apple_pay
authorize
authorize3d
avs
blacklist
capture
cashu
chargeback
chargeback_by_date
credit
fraud_report
fraud_report_by_date
google_pay
init_recurring
init_recurring_sale3d
online_banking_payin
online_banking_payout
nativa
p24
pay_pal
payout
ppro
poli
reconcile
reconcile_by_date
recurring_sale
refund
retrieval
retrieval_by_date
sale
sale3d
void
wpf_create
wpf_reconcile
```

Transaction Parameters
----------------------
`wpf_create.transaction_types`:
  * `authorize`
  * `authorize3d`
  * `sale`
  * `sale3d`
  * `init_recurring_sale`
  * `init_recurring_sale3d`
  * `alipay`
  * `argencard`
  * `aura`
  * `bancomer`
  * `boleto`
  * `bcmc`
  * `baloto`
  * `banco_do_brasil`
  * `bitpay_sale`
  * `bitpay_payout`
  * `bradesco`
  * `cashu`
  * `container_store`
  * `cabal`
  * `cencosud`
  * `davivienda`
  * `ezeewallet`
  * `e_wallet`
  * `efecty`
  * `elo`
  * `eps`
  * `fashioncheque`
  * `google_pay`
  * `apple_pay`
  * `invoice`
  * `itau`
  * `ideal`
  * `idebit_payin`
  * `insta_debit_payin`
  * `intersolve`
  * `multibanco`
  * `my_bank`
  * `naranja`
  * `nativa`
  * `neosurf`
  * `neteller`
  * `online_banking`
  * `oxxo`
  * `ppro`
      * `eps`
      * `ideal`
      * `przelewy24`
      * `safetypay`
      * `trustpay`
      * `bcmc`
      * `mybank`
  * `poli`
  * `p24`
  * `pay_pal`
  * `payu`
  * `post_finance`
  * `pago_facil`
  * `pse`
  * `upi`
  * `rapi_pago`
  * `radpagos`
  * `santander`
  * `safetypay`
  * `sofort`
  * `webmoney`
  * `sdd_init_recurring_sale`
  * `tarjeta_shopping`
  * `trustpay`
  * `trustly_sale`
  * `webpay`
  * `wechat`
  * `russian_mobile_sale`

In order to get a full list of required and optional parameters, please consult our API Documentation.

## Development
Run mocha tests

```js
npm test
```
Build the project

```js
npm run cake-build
```
Watch changed files during development

```js
npm run cake-watch
```
