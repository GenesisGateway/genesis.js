path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

BusinessAttributes    = require '../../business_attributes'
CredentialOnFile      = require '../../../examples/attributes/credential_on_file'
Crypto                = require '../../../examples/attributes/financial/crypto'
CSEncription          = require '../../../examples/attributes/client_side_encryption'
DynamicDescriptor     = require '../../../examples/attributes/financial/dynamic_descriptor'
FakeConfig            = require path.resolve './test/transactions/fake_config'
FakeData              = require '../../fake_data'
FundingAttributes     = require '../../../examples/attributes/financial/funding_attributes'
Gaming                = require '../../../examples/attributes/financial/gaming'
ManagedRecurring      = require '../../../examples/attributes/financial/recurring/managed_recurring'
Moto                  = require '../../../examples/attributes/financial/moto'
MpiParams             = require '../../../examples/attributes/threeds/v1/mpi_params'
RecurringType         = require '../../../examples/attributes/financial/recurring_type'
RiskParams            = require '../../../examples/attributes/risk_params'
ScaParams             = require '../../../examples/attributes/sca_params'
SchemeTokenized       = require './scheme_tokenized'
ThreeDBase            = require './three_d_base'
ThreedsV2             = require '../../../examples/attributes/threeds/v2/threeds_v2'
Transaction           = require path.resolve './src/genesis/transactions/financial/cards/sale3d'
TravelData            = require '../../../examples/attributes/financial/travel_data/travel_data'
UCOF                  = require '../../../examples/attributes/ucof'
InstallmentAttributes = require '../../../examples/attributes/financial/installment_attributes'

describe 'Sale 3D Transaction', ->

  beforeEach ->
    @fakeData = new FakeData
    @data = @fakeData.getDataWithBusinessAttributes()

    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['managed_recurring']  = @fakeData.getManagedRecurringAutomatic()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  describe 'when Threeds V2 Color Depth', ->
    it 'handles color depth properly', ->
      data = _.clone(@data)
      data = _.extend data, @fakeData.getThreedsV2Data()
      data.threeds_v2_params.browser.color_depth = '28'

      @transaction = new Transaction(data, @configuration)

      assert.equal @transaction.getTrxData().payment_transaction.threeds_v2_params.browser.color_depth, 24

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
  SchemeTokenized()
  InstallmentAttributes()
