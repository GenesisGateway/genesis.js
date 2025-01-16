path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData        = require '../../fake_data'
Transaction     = require path.resolve './src/genesis/transactions/financial/obp/p24'
AlternativeBase = require '../../financial/alternative/alternative_base'

describe 'P24 Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction()

    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.billing_address.country = faker.address.countryCode()
    if @data.billing_address.country == 'CA' then @data['billing_address']['state'] = 'AB'
    if @data.billing_address.country == 'US' then @data['billing_address']['state'] = 'AL'

  context 'with valid request', ->

  it 'work when bank_code parameter added', ->
    data             = _.clone @data
    data.currency = "USD"
    data.bank_code= "666"
    assert.equal true, @transaction.setData(data).isValid()

  it 'not fails when existing bank_code parameter added', ->
    data                               = _.clone @data
    data.billing_address.country = "PL"
    data.bank_code                  = "154"
    assert.equal true, @transaction.setData(data).isValid()

  it 'works when correct combination of currency/bank_code used', ->
    data           = _.clone @data
    data.currency  = "EUR"
    data.bank_code = "154"
    assert.equal true, @transaction.setData(data).isValid()

  it 'works when integer bank_code', ->
    data           = _.clone @data
    data.currency  = "EUR"
    data.bank_code = 154
    assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

  it 'fails when wrong country parameter added', ->
    data                         = _.clone @data
    data.billing_address.country = 'NOT_VALID_COUNTRY'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong combination of currency/bank_code used', ->
    data              = _.clone @data
    data.currency  = "EUR"
    data.bank_code = "666"
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when EUR currency and no bank_code used', ->
    data          = _.clone @data
    data.currency = "EUR"
    delete data.bank_code
    assert.equal false, @transaction.setData(data).isValid()

  AlternativeBase()
