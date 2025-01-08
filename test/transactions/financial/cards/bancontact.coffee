faker       = require 'faker'
path        = require 'path'
_           = require 'underscore'
Currency    = require path.resolve './src/genesis/helpers/currency'
FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/bancontact'

describe 'Bancontact Transaction', ->

  before ->
    @data                     = (new FakeData).getMinimumData()
    @data.currency            = faker.random.arrayElement (new Currency).getCurrencies()
    @data.amount              = faker.datatype.number().toString()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.billing_address     = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'Brussels',
      neighborhood: 'Zorenborg',
      country: 'BE'
    }
    @data.shipping_address    = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'Brussels',
      neighborhood: 'Zorenborg',
      country: 'BE'
    }

    @transaction              = new Transaction()

  context 'with invalid request', ->

    it 'fails with unsupported currency and country', ->
      data = _.clone @data
      data['currency'] = 'USD'
      data['billing_address']['country'] = 'BG'

      assert.equal false, @transaction.setData(data).isValid()

  context 'with valid request', ->

    it 'works when valid parameters added', ->
      data = _.clone @data
      data['currency'] = 'EUR'
      data['billing_address']['country'] = 'BE'

      assert.equal true, @transaction.setData(data).isValid()

