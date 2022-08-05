path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData    = require '../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cancel'
Base        = require '../base'

describe 'Cancel Transaction', ->

  before ->
    @data        = (new FakeData).getMinimumData()
    @transaction = new Transaction()

    @data['reference_id'] = faker.datatype.number().toString()

  Base()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()
