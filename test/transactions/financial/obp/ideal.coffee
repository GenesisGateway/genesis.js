path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require path.resolve './test/transactions/fake_data'
FinancialBase = require path.resolve './test/transactions/financial/financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/obp/ideal'

describe 'iDeal Transaction', ->

  beforeEach ->
    @data                     = (new FakeData).getMinimumData()
    @data.currency            = 'EUR'
    @data.amount              = faker.datatype.number().toString()
    @data.usage               = faker.lorem.sentence()
    @data.bic                 = 'INGBNL2A'
    @data.notification_url    = faker.internet.url()
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
      country: 'NL'
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'NL'
    }

    @transaction              = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'NL'
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when bic optional', ->
      data = _.clone @data
      delete data.bic
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when notification_url optional', ->
      data = _.clone @data
      delete data.notification_url
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when return_pending_url optional', ->
      data = _.clone @data
      delete data.return_pending_url
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when bic optional', ->
      data = _.clone @data
      delete data.bic
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

    it 'fails when not valid BIC', ->
      data = _.clone @data
      data.bic = 'NOT_VALID_BIC_CODE_123'
      assert.equal false, @transaction.setData(data).isValid()

  FinancialBase()
