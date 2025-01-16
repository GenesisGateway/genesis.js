path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Currency            = require path.resolve './src/genesis/helpers/currency'
FakeData            = require '../../fake_data'
Transaction         = require path.resolve './src/genesis/transactions/financial/obp/santander'
FinancialBase       = require '../financial_base'
AlternativeExamples = require '../alternative/alternative_base'

describe 'Santander Transaction', ->

  beforeEach ->
    fakeData     = new FakeData()
    @transaction = new Transaction()
    @data        = fakeData.getApmData()
    delete @data.customer_phone

    @data.billing_address.country = faker.random.arrayElement(['AR', 'BR', 'MX', 'CL'])
    @data.currency                = faker.random.arrayElement (new Currency).getCurrencies()
    @data.amount                  = faker.datatype.number().toString()
    @data.customer_email          = faker.internet.email()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.return_pending_url      = faker.internet.url()
    @data.remote_ip               = faker.internet.ip()
    @data.consumer_reference      = 'Consumer Reference'
    @data.national_id             = '8812128812'
    @data.birth_date              = '30-12-1992'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

    @transaction                  = new Transaction()

  AlternativeExamples()

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data                         = _.clone @data
      data.billing_address.country = 'BR'
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

    it 'fails when consumer_reference missing', ->
      data = _.clone @data
      delete data.consumer_reference
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when national_id missing', ->
      data = _.clone @data
      delete data.national_id
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when not supported country parameter added', ->
      data                         = _.clone @data
      data.billing_address.country = 'AT'
      assert.equal false, @transaction.setData(data).isValid()
