path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig  = require path.resolve './test/transactions/fake_config'
FakeData    = require path.resolve './test/transactions/fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/alternative/trustly/sale'

AlternativeBase = require './../alternative_base'

describe 'TrustlySale Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['remote_ip']                  = faker.internet.ip()
    @data['return_success_url']         = faker.internet.url()
    @data['return_failure_url']         = faker.internet.url()
    @data['customer_email']             = faker.internet.email()
    @data['user_id']                    = faker.datatype.number().toString()
    @data['billing_address']['country'] = faker.random.arrayElement([
      "AT", "BE", "CZ", "DK", "EE", "FI", "DE", "LV", "LT", "NL", "NO", "PL",
      "SK", "ES", "SE", "GB"
    ])

  it 'fails when wrong country parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = 'NOT_VALID_COUNTRY'

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing billing_address', ->
    data = _.clone @data
    delete data.billing_address
    assert.equal false, @transaction.setData(data).isValid()

  it 'works when existing billing_address country parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = 'AT'
    assert.equal true, @transaction.setData(data).isValid()

  AlternativeBase()


