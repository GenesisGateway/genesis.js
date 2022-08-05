path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../../../fake_data'
FinancialBase      = require '../../financial_base'
BusinessAttributes = require '../../../business_attributes'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/recurring_sale'
Moto               = require '../../../../examples/attributes/financial/moto'
Gaming             = require '../../../../examples/attributes/financial/gaming'

describe 'RecurringSale Transaction', ->

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

  Moto()
  Gaming()
