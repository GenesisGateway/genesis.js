faker = require 'faker'
path  = require 'path'
_     = require 'underscore'


AccountOwnerAttributes        = require '../../../examples/attributes/financial/account_owner_attributes'
BusinessAttributes            = require '../../business_attributes'
CardBase                      = require './card_base'
CredentialOnFile              = require '../../../examples/attributes/credential_on_file'
Crypto                        = require '../../../examples/attributes/financial/crypto'
CSEncription                  = require '../../../examples/attributes/client_side_encryption'
DynamicDescriptor             = require '../../../examples/attributes/financial/dynamic_descriptor'
DynamicDescriptorMerchantName = require '../../../examples/attributes/financial/dynamic_descriptor_merchant_name'
FakeConfig                    = require path.resolve './test/transactions/fake_config'
FakeData                      = require '../../fake_data'
FundingAttributes             = require '../../../examples/attributes/financial/funding_attributes'
Gaming                        = require '../../../examples/attributes/financial/gaming'
ManagedRecurring              = require '../../../examples/attributes/financial/recurring/managed_recurring'
Moto                          = require '../../../examples/attributes/financial/moto'
RecurringType                 = require '../../../examples/attributes/financial/recurring_type'
RiskParams                    = require '../../../examples/attributes/risk_params'
ScaParams                     = require '../../../examples/attributes/sca_params'
SchemeTokenized               = require './scheme_tokenized'
SubsequentRecurringAttributes = require '../../../examples/attributes/financial/recurring/subsequent_recurring_attributes'
Transaction                   = require path.resolve './src/genesis/transactions/financial/cards/sale'
TravelData                    = require '../../../examples/attributes/financial/travel_data/travel_data'
UCOF                          = require '../../../examples/attributes/ucof'
InstallmentAttributes         = require '../../../examples/attributes/financial/installment_attributes'

describe 'Sale Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getDataWithBusinessAttributes()
    @transaction = new Transaction(@data, FakeConfig.getConfig())
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
  DynamicDescriptorMerchantName()
  CredentialOnFile()
  UCOF()
  TravelData()
  CSEncription()
  FundingAttributes()
  AccountOwnerAttributes()
  SubsequentRecurringAttributes()
  SchemeTokenized
  InstallmentAttributes()
