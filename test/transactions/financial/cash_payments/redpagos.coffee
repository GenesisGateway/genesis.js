path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Currency    = require path.resolve './src/genesis/helpers/currency'
FakeConfig  = require path.resolve './test/transactions/fake_config'
FakeData    = require path.resolve './test/transactions/fake_data'
Transaction = require path.resolve ('./src/genesis/transactions/financial/cash_payments/redpagos')

describe 'Redpagos Transaction', ->

  beforeEach ->
    @data                     = (new FakeData).getMinimumData()
    @data.currency            = faker.random.arrayElement (new Currency).getCurrencies()
    @data.amount              = faker.datatype.number().toString()
    @data.customer_email      = faker.internet.email()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.remote_ip           = faker.internet.ip()
    @data.consumer_reference  = '12346789'
    @data.national_id         = '8812128812'
    @data.birth_date          = '30-12-1992'
    @data.billing_address     = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'UY'
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'UY'
    }

    @transaction              = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'UY'
      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when not supported country parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'GR'
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid currency parameter added', ->
      data = _.clone(@data)
      data.currency = 'NOT_VALID_CURRENCY'
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing customer email', ->
      data = _.clone(@data)
      delete data.customer_email
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing consumer reference', ->
      data = _.clone(@data)
      delete data.consumer_reference
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing national id', ->
      data = _.clone(@data)
      delete data.national_id
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing customer email', ->
      data = _.clone(@data)
      delete data.customer_email
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing amount', ->
      data = _.clone(@data)
      delete data.amount
      assert.equal false, @transaction.setData(data).isValid()
