path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require path.resolve './test/transactions/fake_data'
FinancialBase = require path.resolve './test/transactions/financial/financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/preauthorization/incremental_authorize'

describe 'Incremental Authorize Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getSimpleData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()

  FinancialBase()
