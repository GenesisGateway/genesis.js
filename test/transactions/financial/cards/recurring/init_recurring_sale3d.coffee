path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData                = require '../../../fake_data'
ThreeDBase              = require '../three_d_base'
BusinessAttributes      = require '../../../business_attributes'
Transaction             =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale3d'
ScaParams               = require '../../../../examples/attributes/sca_params'
Moto                    = require '../../../../examples/attributes/financial/moto'
Gaming                  = require '../../../../examples/attributes/financial/gaming'
Crypto                  = require '../../../../examples/attributes/financial/crypto'
ThreedsV2               = require '../../../../examples/attributes/threeds/v2/threeds_v2'
RiskParams              = require '../../../../examples/attributes/risk_params'
DynamicDescriptor       = require '../../../../examples/attributes/financial/dynamic_descriptor'
CredentialOnFile        = require '../../../../examples/attributes/credential_on_file'
TravelData              = require '../../../../examples/attributes/financial/travel_data/travel_data'
AccountOwnerAttributes  = require '../../../../examples/attributes/financial/account_owner_attributes'
MpiParams               = require '../../../../examples/attributes/threeds/v1/mpi_params'
FundingAttributes       = require '../../../../examples/attributes/financial/funding_attributes'
UCOF                    = require '../../../../examples/attributes/ucof'

describe 'InitRecurringSale 3D Transaction', ->

  before ->
    @data        = (new FakeData).getDataWithBusinessAttributes()
    @transaction = new Transaction()

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
