path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

BusinessAttributes    = require '../business_attributes'
FakeConfig            = require path.resolve './test/transactions/fake_config'
FakeData              = require '../fake_data'
FinancialBase         = require './financial_base'
Transaction           = require path.resolve './src/genesis/transactions/financial/capture'
InstallmentAttributes = require '../../examples/attributes/financial/installment_attributes'
TravelAttributes      = require '../../examples/attributes/financial/travel_data/travel_data'

describe 'Capture Transaction', ->

  before ->
    @data        = (new FakeData).getSimpleDataAndBusinessAttributes()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  FinancialBase()
  BusinessAttributes()
  InstallmentAttributes()
  TravelAttributes()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()
