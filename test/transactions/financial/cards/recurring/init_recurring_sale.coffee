path  = require 'path'
_     = require 'underscore'

AccountOwnerAttributes        = require '../../../../examples/attributes/financial/account_owner_attributes'
BusinessAttributes            = require '../../../business_attributes'
CardBase                      = require '../card_base'
CredentialOnFile              = require '../../../../examples/attributes/credential_on_file'
DynamicDescriptor             = require '../../../../examples/attributes/financial/dynamic_descriptor'
DynamicDescriptorMerchantName = require '../../../../examples/attributes/financial/dynamic_descriptor_merchant_name'
FakeConfig                    = require path.resolve './test/transactions/fake_config'
FakeData                      = require '../../../fake_data'
FundingAttributes             = require '../../../../examples/attributes/financial/funding_attributes'
ManagedRecurring              = require '../../../../examples/attributes/financial/recurring/managed_recurring'
Moto                          = require '../../../../examples/attributes/financial/moto'
RiskParams                    = require '../../../../examples/attributes/risk_params'
SchemeTokenized               = require '../scheme_tokenized'
Transaction                   =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale'
TravelData                    = require '../../../../examples/attributes/financial/travel_data/travel_data'

describe 'InitRecurringSale Transaction', ->

  before ->
    @data        = (new FakeData).getDataWithBusinessAttributes()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['managed_recurring'] = (new FakeData).getManagedRecurringManual()

  CardBase()
  BusinessAttributes()
  Moto()
  ManagedRecurring()
  RiskParams()
  DynamicDescriptor()
  DynamicDescriptorMerchantName()
  CredentialOnFile()
  TravelData()
  AccountOwnerAttributes()
  FundingAttributes()
  SchemeTokenized()
