path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/alternative/p24'

AlternativeBase = require './alternative_base'

describe 'P24 Transaction', ->

  before ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction()

    @data['remote_ip']                  = faker.internet.ip()
    @data['return_success_url']         = faker.internet.url()
    @data['return_failure_url']         = faker.internet.url()
    @data['customer_email']             = faker.internet.email()
    @data['billing_address']['country'] = faker.random.arrayElement([
      "AD", "AT", "BE", "CY", "CZ", "DK", "EE", "FI", "FR", "EL", "ES",
      "NL", "IE", "IS", "LT", "LV", "LU", "MT", "DE", "NO", "PL", "PT",
      "SM", "SK", "SI", "CH", "SE", "HU", "GB", "IT", "US", "CA", "JP",
      "UA", "BY", "RU"
    ])
    if @data['billing_address']['country'] == 'CA' then @data['billing_address']['state'] = 'AB'
    if @data['billing_address']['country'] == 'US' then @data['billing_address']['state'] = 'AL'

  it 'fails when wrong country parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = 'NOT_VALID_COUNTRY'
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fails when existing bank_code parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = 'AD'
    data['bank_code'] = "154"
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when wrong bank_code parameter added', ->
    data = _.clone @data
    data['bank_code'] = "100"
    assert.equal false, @transaction.setData(data).isValid()

  AlternativeBase()


