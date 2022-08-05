path  = require 'path'
_     = require 'underscore'
faker = require 'faker'
sinon = require 'sinon'

FakeData      = require '../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/financial/capture'
FinancialBase = require './financial_base'
BusinessAttributes    = require '../business_attributes'

describe 'Capture Transaction', ->

  before ->
    @data        = (new FakeData).getSimpleDataAndBusinessAttributes()
    @transaction = new Transaction()

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  FinancialBase()
  BusinessAttributes()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()
