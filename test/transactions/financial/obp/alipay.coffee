path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require '../../fake_data'
FinancialBase = require '../financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/obp/alipay'

describe 'Alipay Transaction', ->

  before ->
    @data                       = (new FakeData).getSimpleData()
    @data['currency']           = 'EUR'
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @transaction                = new Transaction(@data, FakeConfig.getConfig())

  FinancialBase()

  context 'with invalid currency', ->

    it 'raises a validation error', ->
      data = _.clone(@data)
      data.currency = 'MYR'

      assert.equal false, @transaction.setData(data).isValid()
