path  = require 'path'
_     = require 'underscore'

AccountOwnerAttributes        = require '../../../examples/attributes/financial/account_owner_attributes'
CardBase                      = require './card_base'
CredentialOnFile              = require '../../../examples/attributes/credential_on_file'
Crypto                        = require '../../../examples/attributes/financial/crypto'
CSEncription                  = require '../../../examples/attributes/client_side_encryption'
DigitalAssetTypes             = require '../../../examples/attributes/digital_asset_types'
DynamicDescriptor             = require '../../../examples/attributes/financial/dynamic_descriptor'
DynamicDescriptorMerchantName = require '../../../examples/attributes/financial/dynamic_descriptor_merchant_name'
FakeConfig                    = require path.resolve './test/transactions/fake_config'
FakeData                      = require '../../fake_data'
Gaming                        = require '../../../examples/attributes/financial/gaming'
Moto                          = require '../../../examples/attributes/financial/moto'
Transaction                   = require path.resolve './src/genesis/transactions/financial/cards/payout'
UcofExamples                  = require '../../../examples/attributes/ucof'
PurposeOfPayment              = require '../../../examples/attributes/financial/purpose_of_payment'

describe 'Payout Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  CardBase()
  Moto()
  Gaming()
  Crypto()
  DigitalAssetTypes()
  DynamicDescriptor()
  DynamicDescriptorMerchantName()
  CredentialOnFile()
  CSEncription()
  AccountOwnerAttributes()
  UcofExamples()
  PurposeOfPayment()
