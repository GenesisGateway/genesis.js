path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

AccountOwnerAttributes        = require '../../../../examples/attributes/financial/account_owner_attributes'
BusinessAttributes            = require '../../../business_attributes'
CredentialOnFile              = require '../../../../examples/attributes/credential_on_file'
Crypto                        = require '../../../../examples/attributes/financial/crypto'
DynamicDescriptor             = require '../../../../examples/attributes/financial/dynamic_descriptor'
DynamicDescriptorMerchantName = require '../../../../examples/attributes/financial/dynamic_descriptor_merchant_name'
FakeConfig                    = require path.resolve './test/transactions/fake_config'
FakeData                      = require '../../../fake_data'
FundingAttributes             = require '../../../../examples/attributes/financial/funding_attributes'
Gaming                        = require '../../../../examples/attributes/financial/gaming'
Moto                          = require '../../../../examples/attributes/financial/moto'
MpiParams                     = require '../../../../examples/attributes/threeds/v1/mpi_params'
RiskParams                    = require '../../../../examples/attributes/risk_params'
ScaParams                     = require '../../../../examples/attributes/sca_params'
SchemeTokenized               = require '../scheme_tokenized'
ThreeDBase                    = require '../three_d_base'
ThreedsV2                     = require '../../../../examples/attributes/threeds/v2/threeds_v2'
Transaction                   =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale3d'
TravelData                    = require '../../../../examples/attributes/financial/travel_data/travel_data'
UCOF                          = require '../../../../examples/attributes/ucof'
TokenizationParams            = require '../../../../examples/attributes/financial/tokenization_params'

describe 'InitRecurringSale 3D Transaction', ->

  beforeEach ->
    @fakeData    = new FakeData
    @data        = @fakeData.getDataWithBusinessAttributes()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()

    @data['managed_recurring'] = @fakeData.getManagedRecurringAutomatic()

  describe 'when Threeds V2 Color Depth', ->
    it 'handles color depth properly', ->
      data = _.clone(@data)
      data = _.extend data, @fakeData.getThreedsV2Data(), @fakeData.getThreedsV2RecurringData()
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
  RiskParams()
  DynamicDescriptor()
  DynamicDescriptorMerchantName()
  CredentialOnFile()
  TravelData()
  AccountOwnerAttributes()
  MpiParams()
  FundingAttributes()
  UCOF()
  SchemeTokenized()
  TokenizationParams()
