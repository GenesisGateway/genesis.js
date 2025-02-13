path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require '../../fake_data'
SDDBase       = require './sdd_base'
Transaction   =
  require path.resolve './src/genesis/transactions/financial/direct_debit/sdd_recurring_sale'

describe 'SddRefund', ->

  SDDBase()

  before ->
    @data        = (new FakeData).getSimpleData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  context 'with reference_id validation', ->

    context 'without reference_id', ->

      it 'is invalid', ->
        assert.isNotTrue @transaction.setData(_.omit @data, 'reference_id').isValid()
