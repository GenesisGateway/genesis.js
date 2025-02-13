path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require '../../fake_data'
FinancialBase = require '../financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/mobile/russian_mobile_sale'

describe 'Russian Mobile Sale Transaction', ->

  beforeEach ->
    @data                    = (new FakeData).getSimpleData()
    @data.remote_ip          = faker.internet.ip()
    @data.return_success_url = faker.internet.url()
    @data.return_failure_url = faker.internet.url()
    @data.currency           = faker.random.arrayElement(["RUB"])
    @data.amount             = '10000'
    @data.customer_email     = faker.internet.email()
    @data.customer_phone     = '+1987987987987'
    @data.operator           = faker.random.arrayElement(
      ["mtc", "megafon", "tele2", "meeline"]
    )
    @data.target             =  '000010'
    @data.billing_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'RU'
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'RU'
    }
    @transaction             = new Transaction(@data, FakeConfig.getConfig())

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

    it 'fails with missing operator', ->
      data = _.clone(@data)
      delete data['operator']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing target', ->
      data = _.clone(@data)
      delete data['target']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid currency', ->
      data = _.clone(@data)
      data['currency'] = 'NOT_VALID'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid country', ->
      data = _.clone(@data)
      data['billing_address']['country'] = 'NOT_VALID'

      assert.equal false, @transaction.setData(data).isValid()
      
    it 'fails with invalid operator', ->
      data = _.clone(@data)
      data['operator'] = 'NOT_VALID'

      assert.equal false, @transaction.setData(data).isValid()
