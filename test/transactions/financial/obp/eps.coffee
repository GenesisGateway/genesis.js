path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require path.resolve './test/transactions/fake_data'
FinancialBase = require path.resolve './test/transactions/financial/financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/obp/eps'

describe 'EPS Transaction', ->

  beforeEach ->
    @data                     = (new FakeData).getMinimumData()
    @data.currency            = 'EUR'
    @data.amount              = faker.datatype.number().toString()
    @data.usage               = faker.lorem.sentence()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.return_pending_url  = faker.internet.url()
    @data.remote_ip           = faker.internet.ip()
    @data.billing_address     = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'AT'
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'AT'
    }

    @transaction              = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'AT'
      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when return_success_url missing', ->
      data = _.clone @data
      delete data.return_success_url
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when return_failure_url missing', ->
      data = _.clone @data
      delete data.return_failure_url
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when not supported country parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'MX'
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when currency is not valid', ->
      data = _.clone @data
      data.currency = 'USD'
      assert.equal false, @transaction.setData(data).isValid()

    FinancialBase()
