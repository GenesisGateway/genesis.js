path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../../fake_data'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/mobile/african_mobile_sale'
FinancialBase      = require '../financial_base'
BusinessAttributes = require '../../business_attributes'

describe 'African Mobile Sale Transaction', ->

  beforeEach ->
    @data                    = (new FakeData).getSimpleData()
    @data.remote_ip          = faker.internet.ip()
    @data.return_success_url = faker.internet.url()
    @data.return_failure_url = faker.internet.url()
    @data.currency           = 'GHS'
    @data.amount             = '10000'
    @data.customer_email     = faker.internet.email()
    @data.customer_phone     = '+1987987987987'
    @data.operator           = "VODACOM"
    @data.target             =  '000010'
    @data.billing_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'GH'
    }
    @transaction             = new Transaction()

  FinancialBase()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with GH country, GHS currency, and VODACOM operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'GH'
      data.currency = 'GHS'
      data.operator = 'VODACOM'

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with KE country, KES currency, and SAFARICOM operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'KE'
      data.currency = 'KES'
      data.operator = 'SAFARICOM'

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with UG country, UGX currency, and AIRTEL operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'UG'
      data.currency = 'UGX'
      data.operator = 'AIRTEL'

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails with invalid country code', ->
      data = _.clone(@data)
      data.billing_address.country = 'BG'
      data.currency = 'GHS'
      data.operator = 'VODACOM'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with valid country code, invalid currency code', ->
      data = _.clone(@data)
      data.billing_address.country = 'GH'
      data.currency = 'BGN'
      data.operator = 'VODACOM'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with valid country code, valid currency code, invalid operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'GH'
      data.currency = 'GHS'
      data.operator = 'INVALID_OPERATOR'

      assert.equal false, @transaction.setData(data).isValid()
