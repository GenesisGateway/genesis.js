path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require path.resolve './test/transactions/fake_data'
FinancialBase = require path.resolve './test/transactions/financial/financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/obp/payu'

describe 'PayU Transaction', ->

  beforeEach ->
    fakeData = new FakeData()

    @data                     = fakeData.getMinimumData()
    @data.currency            = 'CZK'
    @data.amount              = faker.datatype.number().toString()
    @data.customer_email      = faker.internet.email()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.return_pending_url  = faker.internet.url()
    @data.billing_address     = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'CZ'
    @data.shipping_address    = fakeData.getShippingData().shipping_address

    @transaction              = new Transaction(@data, FakeConfig.getConfig())

  FinancialBase()

  context 'with valid request', ->

    it 'work when currency and country parameters added', ->
      data                               = _.clone @data
      data['currency']                   = "PLN"
      data['billing_address']['country'] = "PL"
      assert.equal true, @transaction.setData(data).isValid()

    it 'works with base required parameters', ->
      data = _.clone @data
      delete data.usage
      delete data.remote_ip
      delete data.shipping_address
      delete data.return_pending_url
      delete data.customer_email
      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when wrong country parameter added', ->
      data                         = _.clone @data
      data.billing_address.country = 'NOT_VALID_COUNTRY'
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when country parameter missing', ->
      data = _.clone @data
      delete data.billing_address.country
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when wrong country parameter added', ->
      data                               = _.clone @data
      data['billing_address']['country'] = 'AU'
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when wrong combination of currency/country used', ->
      data                         = _.clone @data
      data.billing_address.country = "PL"
      data.currency                = "CZK"
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when currency not supported', ->
      data          = _.clone @data
      data.currency = 'USD'

      assert.isNotTrue @transaction.setData(data).isValid()
