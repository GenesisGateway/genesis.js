path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base                = require '../../base'
FakeConfig          = require path.resolve './test/transactions/fake_config'
FakeData            = require '../../fake_data'
FinancialBase       = require path.resolve './test/transactions/financial/financial_base'
SmartRouterExamples = require '../../../examples/attributes/financial/smart_router_attributes'
Transaction         =
  require path.resolve './src/genesis/transactions/financial/preauthorization/partial_reversal'

describe 'Partial Reversal Transaction', ->

  beforeEach ->
    @fakeData = new FakeData()
    @data     = @fakeData.getMinimumData()

    @data['amount']        = faker.datatype.number().toString()
    @data['reference_id']  = faker.datatype.number().toString()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'fails when missing required reference_id parameter', ->
    data = _.clone(@data)
    delete data.reference_id
    assert.isNotTrue @transaction.setData(data).isValid()

  Base()
  SmartRouterExamples()
  FinancialBase()
