path  = require 'path'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/verification/kyc_verification_status'

describe 'KYC Verification Status Request', ->

  beforeEach ->
    @data = {
      reference_id: faker.random.alphaNumeric()
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'when invalid request', ->
    it 'fails with missing required parameter', ->
      delete @data.reference_id
      assert.isNotTrue @transaction.setData(@data).isValid()

  context 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/verifications/status'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()
