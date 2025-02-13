path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

AlternativeBase = require '../../financial/alternative/alternative_base'
FakeConfig      = require path.resolve './test/transactions/fake_config'
FakeData        = require '../../fake_data'
Transaction     = require path.resolve './src/genesis/transactions/financial/obp/p24'

describe 'P24 Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data.currency                = "EUR"
    @data.bank_code               = 1000
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.billing_address.country = faker.address.countryCode('alpha-2')

    if @data.billing_address.country == 'CA' then @data['billing_address']['state'] = 'AB'
    if @data.billing_address.country == 'US' then @data['billing_address']['state'] = 'AL'

  context 'with valid request', ->
    it 'work when bank_code parameter added', ->
      data          = _.clone @data
      data.currency = "USD"
      data.bank_code= "666"

      assert.isTrue @transaction.setData(data).isValid()

    it 'not fails when existing bank_code parameter added', ->
      data                         = _.clone @data
      data.billing_address.country = "PL"
      data.bank_code               = "154"

      assert.isTrue @transaction.setData(data).isValid()

    it 'works when correct combination of currency/bank_code used', ->
      data           = _.clone @data
      data.currency  = "EUR"
      data.bank_code = "154"

      assert.isTrue @transaction.setData(data).isValid()

    it 'works when integer bank_code', ->
      data           = _.clone @data
      data.currency  = "EUR"
      data.bank_code = 154

      assert.isTrue @transaction.setData(data).isValid()

    it 'work without bank_code and specific currency', ->
      data          = _.clone @data
      data.currency = "USD"
      delete data.bank_code

      assert.isTrue @transaction.setData(data).isValid()

  context 'with invalid request', ->
    it 'fails when wrong country parameter added', ->
      data                         = _.clone @data
      data.billing_address.country = 'NOT_VALID_COUNTRY'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when wrong combination of currency/bank_code used', ->
      data           = _.clone @data
      data.currency  = "EUR"
      data.bank_code = "666"

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when EUR currency and no bank_code used', ->
      data          = _.clone @data
      data.currency = "EUR"
      delete data.bank_code

      assert.isNotTrue @transaction.setData(data).isValid()

  AlternativeBase()
