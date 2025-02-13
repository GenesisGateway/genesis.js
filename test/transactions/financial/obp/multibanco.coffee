path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Currency      = require path.resolve './src/genesis/helpers/currency'
FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require path.resolve './test/transactions/fake_data'
FinancialBase = require path.resolve './test/transactions/financial/financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/obp/multibanco'

describe 'Multibanco Transaction', ->

  beforeEach ->
    @data                     = (new FakeData).getMinimumData()
    @data.currency            = faker.random.arrayElement (new Currency).getCurrencies()
    @data.amount              = faker.datatype.number().toString()
    @data.customer_email      = faker.internet.email()
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
      country: 'PT'
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'PT'
    }

    @transaction              = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'PT'
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when return_pending_url optional', ->
      data = _.clone @data
      delete data.return_pending_url
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when usage optional', ->
      data = _.clone @data
      delete data.usage
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when customer_email optional', ->
      data = _.clone @data
      delete data.customer_email
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

    FinancialBase()
