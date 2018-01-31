path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData      = require '../../../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/financial/cards/recurring/recurring_sale'
FinancialBase = require '../../financial_base'

describe 'RecurringSale Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

    @data['reference_id'] = faker.random.number()

  FinancialBase()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()
