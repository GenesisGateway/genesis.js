path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../../fake_data'
Transaction        = require path.resolve './src/genesis/transactions/financial/obp/my_bank'
FinancialBase      = require '../financial_base'

describe 'MyBank Transaction', ->

  beforeEach ->
    @data                     = (new FakeData).getMinimumData()

    @data.usage                   = '40208 concert tickets'
    @data.remote_ip           = faker.internet.ip()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.return_pending_url  = faker.internet.url()
    @data.currency            = 'EUR'
    @data.amount              = faker.datatype.number().toString()

    @data.billing_address     = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: faker.random.arrayElement([
        "IT", "BE", "PT", "ES"
      ])
    }

    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'AR'
    }

    @transaction              = new Transaction()

  context 'with valid request', ->

    it 'works when valid currency parameter added', ->
      data = _.clone @data
      data.currency = 'EUR'

      assert.equal true, @transaction.setData(data).isValid()

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data['billing_address']['country'] = 'IT'

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when invalid currency parameter added', ->
      data = _.clone @data
      data.currency = 'USD'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when missing return_success_url parameter', ->
      data = _.clone @data
      delete data.return_success_url

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when missing return_success_url parameter', ->
      data = _.clone @data
      delete data.return_failure_url

      assert.equal false, @transaction.setData(data).isValid()
