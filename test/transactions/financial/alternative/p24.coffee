path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/alternative/p24'

AlternativeBase = require './alternative_base'

describe 'P24 Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

    @data['remote_ip'] = faker.internet.ip()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['customer_email']  = faker.internet.email()
    @data['billing_address']['country'] = faker.random.arrayElement(@transaction.fieldsValues['billing_address.country'])

  AlternativeBase()

  it 'fails when wrong country parameter', ->
    data = _.clone @data
    data['billing_address']['country'] = 'NOT_VALID_COUNTRY';
    assert.equal false, @transaction.setData(data).isValid()