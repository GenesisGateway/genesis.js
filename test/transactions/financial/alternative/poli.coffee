path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/alternative/poli'

AlternativeBase = require './alternative_base'

describe 'Poli Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction()

    @data['remote_ip']                  = faker.internet.ip()
    @data['return_success_url']         = faker.internet.url()
    @data['return_failure_url']         = faker.internet.url()
    @data['customer_email']             = faker.internet.email()
    @data['currency']                   = faker.random.arrayElement(['AUD', 'NZD'])
    @data['billing_address']['country'] = faker.random.arrayElement(['AU', 'NZ'])

  it 'fails when wrong country parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = faker.random.arrayElement(['NOT_VALID_COUNTRY', 'UK'])

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong currency parameter added', ->
    data = _.clone @data
    data['currency'] = faker.random.arrayElement(['NOT_VALID_CURRENCY', 'EUR'])

    assert.equal false, @transaction.setData(data).isValid()

  it 'works with allowed currency list AUD or NZD', ->
    data = _.clone @data
    data['currency'] = faker.random.arrayElement(['AUD', 'NZD'])

    assert.equal true, @transaction.setData(data).isValid()

  it 'works with allowed country list AU or NZ', ->
    data = _.clone @data
    data['billing_address']['country'] = faker.random.arrayElement(['AU', 'NZ'])

    assert.equal true, @transaction.setData(data).isValid()

  AlternativeBase()


