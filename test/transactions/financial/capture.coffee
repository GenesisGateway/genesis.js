path  = require 'path'
_     = require 'underscore'
faker = require 'faker'
sinon = require 'sinon'

FakeData      = require '../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/financial/capture'
FinancialBase = require './financial_base'

describe 'Capture Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @data['reference_id'] = faker.datatype.number()

    @transaction = new Transaction()

  FinancialBase()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()
