path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
FakeData    = require '../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cancel'
SmartRouter = require '../../examples/attributes/financial/smart_router_attributes'

describe 'Cancel Transaction', ->

  before ->
    @data        = (new FakeData).getMinimumData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['reference_id'] = faker.datatype.number().toString()

  Base()
  SmartRouter()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()
