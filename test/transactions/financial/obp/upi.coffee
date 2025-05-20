path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require path.resolve './test/transactions/fake_data'
Transaction        = require path.resolve (
  './src/genesis/transactions/financial/obp/upi'
)

AlternativeBase    = require path.resolve './test/transactions/financial/alternative/alternative_base'

describe 'Upi Transaction', ->

  beforeEach ->
    @data                         = (new FakeData).getApmData()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.currency                = "INR"
    @data.document_id             = faker.datatype.number().toString()
    @data.virtual_payment_address = faker.internet.email()
    @data.user_category           = faker.random.arrayElement(['individual', 'business', 'default'])
    @transaction                  = new Transaction(@data, FakeConfig.getConfig())

  context 'with invalid request', ->

    it 'fails with invalid currency parameter added', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(['NOT_VALID_CURRENCY'])
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid currency value', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(['USD'])
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing return_success_url', ->
      data = _.clone @data
      delete data.return_success_url
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing return_failure_url', ->
      data = _.clone @data
      delete data.return_failure_url
      assert.equal false, @transaction.setData(data).isValid()

  context 'with valid request', ->
    it 'works with all required parameters', ->
      data = _.clone @data
      assert.equal true, @transaction.setData(data).isValid()

    it 'works with minimum required parameters', ->
      data = _.clone @data
      delete data.usage
      delete data.remote_ip
      delete data.customer_email
      delete data.customer_phone
      delete data.document_id
      delete data.virtual_payment_address
      delete data.user_category
      assert.equal true, @transaction.setData(data).isValid()

  AlternativeBase()
