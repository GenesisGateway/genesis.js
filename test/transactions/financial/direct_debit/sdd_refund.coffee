path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData      = require '../../fake_data'
SDDBase       = require './sdd_base'
Transaction   =
  require path.resolve './src/genesis/transactions/financial/direct_debit/sdd_recurring_sale'

describe 'SddRefund', ->

  SDDBase()

  before ->
    @data['reference_id'] = faker.random.number()

    @transaction = new Transaction()

  context 'with reference_id validation', ->

    context 'without reference_id', ->

      it 'is invalid', ->
        assert.isNotTrue @transaction.setData(_.omit @data, 'reference_id').isValid()
