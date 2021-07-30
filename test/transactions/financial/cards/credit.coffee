path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData      = require '../../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/financial/cards/credit'
FinancialBase = require '../financial_base'

describe 'Credit Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @data['reference_id'] = faker.datatype.number()

    @transaction = new Transaction()

  FinancialBase()
