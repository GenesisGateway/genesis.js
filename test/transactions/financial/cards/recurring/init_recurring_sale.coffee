path  = require 'path'
_     = require 'underscore'

FakeData           = require '../../../fake_data'
CardBase           = require '../card_base'
BusinessAttributes = require '../../../business_attributes'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale'
Moto               = require '../../../../examples/attributes/financial/moto'
ManagedRecurring   = require '../../../../examples/attributes/financial/recurring/managed_recurring'
RiskParams         = require '../../../../examples/attributes/risk_params'
DynamicDescriptor  = require '../../../../examples/attributes/financial/dynamic_descriptor'

describe 'InitRecurringSale Transaction', ->

  before ->
    @data        = (new FakeData).getDataWithBusinessAttributes()
    @transaction = new Transaction()

    @data['managed_recurring'] = (new FakeData).getManagedRecurringManual()

  CardBase()
  BusinessAttributes()
  Moto()
  ManagedRecurring()
  RiskParams()
  DynamicDescriptor()
