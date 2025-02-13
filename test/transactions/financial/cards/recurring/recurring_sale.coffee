path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

BusinessAttributes = require '../../../business_attributes'
FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require '../../../fake_data'
FinancialBase      = require '../../financial_base'
FundingAttributes  = require '../../../../examples/attributes/financial/funding_attributes'
Gaming             = require '../../../../examples/attributes/financial/gaming'
Moto               = require '../../../../examples/attributes/financial/moto'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/recurring_sale'
TravelData         = require '../../../../examples/attributes/financial/travel_data/travel_data'

describe 'RecurringSale Transaction', ->

  before ->
    @data        = (new FakeData).getSimpleDataAndBusinessAttributes()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  FinancialBase()
  BusinessAttributes()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()

  Moto()
  Gaming()
  TravelData()
  FundingAttributes()
