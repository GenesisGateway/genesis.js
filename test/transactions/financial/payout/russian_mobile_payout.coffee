path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require path.resolve './test/transactions/fake_data'
FinancialBase      = require path.resolve './test/transactions/financial/financial_base'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/payout/russian_mobile_payout'

describe 'Russian Mobile Payout Transaction', ->

  beforeEach ->
    fakeData     = new FakeData
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data                         = fakeData.getSimpleData()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.currency                = 'RUB'
    @data.amount                  = '10000'
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'RU'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

  FinancialBase()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails with missing return_success_url', ->
      data = _.clone(@data)
      delete data['return_success_url']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing return_failure_url', ->
      data = _.clone(@data)
      delete data['return_failure_url']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid currency', ->
      data = _.clone(@data)
      data['currency'] = 'EUR'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid country', ->
      data = _.clone(@data)
      data['billing_address']['country'] = 'EU'

      assert.equal false, @transaction.setData(data).isValid()
