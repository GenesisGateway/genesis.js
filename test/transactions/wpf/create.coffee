path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../fake_data'
Transaction        = require path.resolve './src/genesis/transactions/wpf/create'
FinancialBase      = require '../financial/financial_base'
BusinessAttributes = require '../business_attributes'
i18n               = require path.resolve 'src/genesis/helpers/i18n'

describe 'WPFCreate Transaction', ->

  before ->
    @data        = (new FakeData).getSimpleDataAndBusinessAttributes()
    @transaction = new Transaction()

    delete @data.remote_ip
    @data['transaction_types']  = ['sale', 'authorize']
    @data['locale']             = faker.random.arrayElement((new i18n).getLocales())
    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['return_cancel_url']  = faker.internet.url()

  it 'fails when missing required transaction_types parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'transaction_types').isValid()

  it 'fails when wrong transaction_type', ->
    data = _.clone @data
    data.transaction_types = [
      {
        NOT_VALID_TYPE:{}
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fails when transaction_type exists', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: '123456'
        }
      },
      'sale'
    ]

    assert.equal true, @transaction.setData(data).isValid()

  it 'not fails when custom attribute of transaction_type exists', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: "123456"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when custom attribute of transaction_type not exists', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          NOT_VALiD_CUSTOM_ATTRIBUTE: "1111111111"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong type of custom attribute ', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: 111
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong length of bin custom attribute ', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          bin: "12345"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong format of custom attribute expiration_date', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          expiration_date: "10-2020"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fails with correct format of custom attribute expiration_date', ->
    data = _.clone @data
    data.transaction_types = [
      {
        authorize: {
          expiration_date: "2020-10"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when missing required parameter crypto_wallet_provider of bitpay custom attribute', ->
    data = _.clone @data
    data.transaction_types = [
      {
        bitpay_payout: {
          crypto_address: "CRYPTO_ADDRESS"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fails when all required custom attributes of bitpay are set', ->
    data = _.clone @data
    data.transaction_types = [
      {
        bitpay_payout: {
          crypto_address: "CRYPTO_ADDRESS",
          crypto_wallet_provider: "CRYPTO_WALLET_PROVIDER"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when unsupported payment_type was set to google_pay custom attribute', ->
    data = _.clone @data
    data.transaction_types = [
      {
        google_pay: {
          payment_subtype: "NOT_VALID_PAYMENT_TYPE"
        }
      }
    ]
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fails when supported payment_subtype was set to google_pay custom attribute', ->
    data = _.clone @data
    data.transaction_types = [
      {
        google_pay: {
          payment_subtype: "authorize"
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  it 'works with correct online_banking structure', ->
    data = _.clone @data
    data.transaction_types = [
      {
        online_banking: {
          bank_codes: [
            {
              bank_code: ["bank_1", "bank_2"]
            }
          ]
        }
      }
    ]
    assert.equal true, @transaction.setData(data).isValid()

  context 'with i18n', ->

    context 'with invalid request', ->

      it 'fails when wrong locale', ->
        data        = _.clone @data
        data.locale = 'NOT_VALID_LOCALE'

        assert.equal false, @transaction.setData(data).isValid()

  context 'with Tokenization attributes', ->

    context 'with invalid parameters', ->
      it 'raise validation error with invalid remember_card', ->
        data               = _.clone @data
        data.remember_card = 'true'

        assert.equal false, @transaction.setData(data).isValid()

      it 'raise validation error with invalid consumer_id', ->
        data             = _.clone @data
        data.consumer_id = faker.datatype.number({min: 11})

        assert.equal false, @transaction.setData(data).isValid()

    context 'with invalid request', ->

      it 'raise validation error with missing customer_email and present consumer_id', ->
        data             = _.clone @data
        data.consumer_id = faker.datatype.number({max: 10}).toString()
        delete data.customer_email

        assert.equal false, @transaction.setData(data).isValid()

    context 'with valid request', ->

      it 'should create consumer', ->
        data               = _.clone @data
        data.remember_card = true

        assert.equal true, @transaction.setData(data).isValid()

      it 'should send token data', ->
        data             = _.clone @data
        data.consumer_id = faker.datatype.number({max: 36}).toString()

        assert.equal true, @transaction.setData(data).isValid()

  BusinessAttributes()
  FinancialBase()
