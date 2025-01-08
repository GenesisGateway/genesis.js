path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Currency    = require path.resolve './src/genesis/helpers/currency'
FakeData    = require path.resolve './test/transactions/fake_data'
Transaction = require path.resolve ('./src/genesis/transactions/financial/cash_payments/pix')

describe 'Pix Transaction', ->

  beforeEach ->
    @data                     = (new FakeData).getMinimumData()
    @data.remote_ip           = faker.internet.ip()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.return_pending_url  = faker.internet.url()
    @data.amount              = faker.datatype.number().toString()
    @data.currency            = faker.random.arrayElement (new Currency).getCurrencies()
    @data.document_id         = '12345678909'
    @data.customer_email      = faker.internet.email()
    @data.mothers_name        = faker.name.lastName()
    @data.gender              = faker.datatype.number(0, 2).toString()
    @data.marital_status      = faker.datatype.number(0, 6).toString()
    @data.sender_occupation   = faker.name.jobTitle()
    @data.nationality         = faker.address.countryCode()
    @data.country_of_origin   = faker.address.countryCode()
    @data.birth_city          = faker.address.city()
    @data.birth_state         = faker.address.state()
    @data.company_type        = faker.datatype.number(0, 8).toString()
    @data.company_activity    = faker.name.jobDescriptor()
    @data.birth_date          = '30-12-1992'
    @data.incorporation_date  = '30-12-1992'
    @data.billing_address     = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'BR'
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'BR'
    }

    @transaction              = new Transaction()

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'BR'
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when integer parameter is used for gender', ->
      data        = _.clone @data
      data.gender = faker.datatype.number(0, 2)
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when integer parameter is used for marital_status', ->
      data                = _.clone @data
      data.marital_status = faker.datatype.number(0, 6)
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when integer parameter is used for company_type', ->
      data                = _.clone @data
      data.marital_status = faker.datatype.number(0, 8)
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

    it 'fails with missing document id', ->
      data = _.clone(@data)
      delete data.document_id
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with missing amount', ->
      data = _.clone(@data)
      delete data.amount
      assert.equal false, @transaction.setData(data).isValid()
