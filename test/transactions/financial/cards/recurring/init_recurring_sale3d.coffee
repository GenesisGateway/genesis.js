path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

AccountOwnerAttributes  = require '../../../../examples/attributes/financial/account_owner_attributes'
BusinessAttributes      = require '../../../business_attributes'
CredentialOnFile        = require '../../../../examples/attributes/credential_on_file'
Crypto                  = require '../../../../examples/attributes/financial/crypto'
DynamicDescriptor       = require '../../../../examples/attributes/financial/dynamic_descriptor'
FakeConfig              = require path.resolve './test/transactions/fake_config'
FakeData                = require '../../../fake_data'
FundingAttributes       = require '../../../../examples/attributes/financial/funding_attributes'
Gaming                  = require '../../../../examples/attributes/financial/gaming'
Moto                    = require '../../../../examples/attributes/financial/moto'
MpiParams               = require '../../../../examples/attributes/threeds/v1/mpi_params'
RiskParams              = require '../../../../examples/attributes/risk_params'
ScaParams               = require '../../../../examples/attributes/sca_params'
ThreeDBase              = require '../three_d_base'
ThreedsV2               = require '../../../../examples/attributes/threeds/v2/threeds_v2'
Transaction             =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale3d'
TravelData              = require '../../../../examples/attributes/financial/travel_data/travel_data'
UCOF                    = require '../../../../examples/attributes/ucof'

describe 'InitRecurringSale 3D Transaction', ->

  before ->
    @data        = (new FakeData).getDataWithBusinessAttributes()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()

    @data['managed_recurring'] = (new FakeData).getManagedRecurringAutomatic()

  ThreeDBase()
  BusinessAttributes()
  ScaParams()
  Moto()
  Gaming()
  Crypto()
  ThreedsV2()
  RiskParams()
  DynamicDescriptor()
  CredentialOnFile()
  TravelData()
  AccountOwnerAttributes()
  MpiParams()
  FundingAttributes()
  UCOF()
