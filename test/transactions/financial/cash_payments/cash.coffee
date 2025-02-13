path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require path.resolve './test/transactions/fake_data'
Transaction        = require path.resolve (
  './src/genesis/transactions/financial/cash_payments/cash'
)

AlternativeBase = require path.resolve './test/transactions/financial/alternative/alternative_base'

describe 'Cash Transaction', ->

  beforeEach ->
    @data                         = (new FakeData).getSimpleData()
    delete @data['usage']
    @data.remote_ip               = faker.internet.ip()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.currency                = faker.random.arrayElement(["MXN"])
    @data.amount                  = '10000'
    @data.customer_email          = faker.internet.email()
    @data.customer_phone          = '+1987987987987'
    @data.payment_type            = faker.random.arrayElement(
      ["seven_eleven", "bancomer", "pharmacies_del_dr_ahorro", "pharmacies_santa_maria", "oxxo", "scotiabank"]
    )
    @data.document_id             = faker.datatype.number().toString()
    @data.billing_address         = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'US'
    }
    @transaction                  = new Transaction(@data, FakeConfig.getConfig())

  context 'with invalid request', ->

    it 'fails with invalid currency parameter added', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(['NOT_VALID_CURRENCY'])

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid wrong payment_type', ->
      data = _.clone @data
      data['payment_type'] = 'NOT_VALID_PAYMENT_TYPE'

      assert.equal false, @transaction.setData(data).isValid()

  context 'with valid request', ->

    it 'works with allowed currency', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(['MXN'])

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with allowed payment_type', ->
      data = _.clone @data
      data['payment_type'] = faker.random.arrayElement(
        ["seven_eleven", "bancomer", "pharmacies_del_dr_ahorro", "pharmacies_santa_maria", "oxxo", "scotiabank"]
      )
      assert.equal true, @transaction.setData(data).isValid()

  AlternativeBase()
