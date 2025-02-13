path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig  = require path.resolve './test/transactions/fake_config'
FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/alternative/paysafecard'

AlternativeBase = require './alternative_base'

describe 'Paysafecard Transaction', ->

  before ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['remote_ip']                  = faker.internet.ip()
    @data['return_success_url']         = faker.internet.url()
    @data['return_failure_url']         = faker.internet.url()
    @data['customer_email']             = faker.internet.email()
    @data['customer_id']                = faker.datatype.number().toString()
    @data['billing_address']['country'] = faker.random.arrayElement([
      "AU", "AT", "BE", "BG", "CA", "HR", "CY", "CZ", "DK", "FI", "FR",
      "GE", "DE", "GI", "GR", "HU", "IS", "IE", "IT", "KW", "LV", "LI",
      "LT", "LU", "MT", "MX", "MD", "ME", "NL", "NZ", "NO", "PY", "PE",
      "PL", "PT", "RO", "SA", "SK", "SI", "ES", "SE", "CH", "TR", "AE",
      "GB", "US", "UY"
    ])

  it 'fails when wrong country parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = 'NOT_VALID_COUNTRY'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing billing_address', ->
    data = _.clone @data
    delete data.billing_address
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing required customer_id parameter', ->
    data = _.clone(@data)
    delete data.customer_id
    assert.equal false, @transaction.setData(data).isValid()

  it 'works when existing billing_address country parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = 'AU'
    assert.equal true, @transaction.setData(data).isValid()

  AlternativeBase()


