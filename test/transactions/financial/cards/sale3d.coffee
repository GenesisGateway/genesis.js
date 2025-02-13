path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

BusinessAttributes = require '../../business_attributes'
CredentialOnFile   = require '../../../examples/attributes/credential_on_file'
Crypto             = require '../../../examples/attributes/financial/crypto'
CSEncription       = require '../../../examples/attributes/client_side_encryption'
DynamicDescriptor  = require '../../../examples/attributes/financial/dynamic_descriptor'
FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require '../../fake_data'
FundingAttributes  = require '../../../examples/attributes/financial/funding_attributes'
Gaming             = require '../../../examples/attributes/financial/gaming'
ManagedRecurring   = require '../../../examples/attributes/financial/recurring/managed_recurring'
Moto               = require '../../../examples/attributes/financial/moto'
MpiParams          = require '../../../examples/attributes/threeds/v1/mpi_params'
RecurringType      = require '../../../examples/attributes/financial/recurring_type'
RiskParams         = require '../../../examples/attributes/risk_params'
ScaParams          = require '../../../examples/attributes/sca_params'
ThreeDBase         = require './three_d_base'
ThreedsV2          = require '../../../examples/attributes/threeds/v2/threeds_v2'
Transaction        = require path.resolve './src/genesis/transactions/financial/cards/sale3d'
TravelData         = require '../../../examples/attributes/financial/travel_data/travel_data'
UCOF               = require '../../../examples/attributes/ucof'

describe 'Sale 3D Transaction', ->

  before ->
    @data = (new FakeData).getDataWithBusinessAttributes()

    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['managed_recurring'] = (new FakeData).getManagedRecurringAutomatic()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  ThreeDBase()
  BusinessAttributes()
  ScaParams()
  Moto()
  Gaming()
  Crypto()
  ThreedsV2()
  RecurringType()
  ManagedRecurring()
  RiskParams()
  DynamicDescriptor()
  CredentialOnFile()
  TravelData()
  CSEncription()
  FundingAttributes()
  MpiParams()
  UCOF()
