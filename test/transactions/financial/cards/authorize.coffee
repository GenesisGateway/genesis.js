faker = require 'faker'
path = require 'path'
_ = require 'underscore'

FakeData           = require '../../fake_data'
Transaction        = require path.resolve './src/genesis/transactions/financial/cards/authorize'
CardBase           = require './card_base'
BusinessAttributes = require '../../business_attributes'
ScaParams          = require '../../../examples/attributes/sca_params'
Moto               = require '../../../examples/attributes/financial/moto'
Gaming             = require '../../../examples/attributes/financial/gaming'
Crypto             = require '../../../examples/attributes/financial/crypto'
RecurringType      = require '../../../examples/attributes/financial/recurring_type'
ManagedRecurring   = require '../../../examples/attributes/financial/recurring/managed_recurring'
RiskParams         = require '../../../examples/attributes/risk_params'
DynamicDescriptor  = require '../../../examples/attributes/financial/dynamic_descriptor'

describe 'Authorize Transaction', ->

  before ->
    @data                      = (new FakeData).getDataWithBusinessAttributes()
    @transaction               = new Transaction()
    @data['managed_recurring'] = (new FakeData).getManagedRecurringAutomatic()

  CardBase()
  BusinessAttributes()
  ScaParams()
  Moto()
  Gaming()
  Crypto()
  RecurringType()
  ManagedRecurring()
  RiskParams()
  DynamicDescriptor()

  context 'when Recurring Type - subsequent', ->
    it 'with reference_id', ->
      data                = _.clone @data
      data.recurring_type = 'subsequent'
      data.reference_id   = faker.datatype.number().toString()

      assert.equal true, @transaction.setData(data).isValid()

    it 'without reference_id', ->
      data                = _.clone @data
      data.recurring_type = 'subsequent'
      delete data.reference_id

      assert.equal false, @transaction.setData(data).isValid()

