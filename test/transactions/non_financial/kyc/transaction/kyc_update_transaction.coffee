path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/transaction/kyc_update_transaction'

describe 'KYC Create Transaction Request', ->

  before ->
    @data = {
      transaction_unique_id: faker.datatype.number().toString()
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/update_transaction'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with all parameters', ->
      data = _.clone @data
      data.session_id           = faker.random.alphaNumeric()
      data.reference_id         = faker.random.alphaNumeric()
      data.transaction_status   = faker.random.arrayElement([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
      data.reason               = faker.random.alpha()
      data.cvv_check_result     = faker.random.alpha()
      data.avs_check_result     = faker.random.alpha()
      data.processor_identifier = faker.random.alpha()
      assert.isTrue @transaction.setData(data).isValid()

  describe 'when invalid request', ->
    it 'fails when missing required parameters', ->
      data = _.clone @data
      delete data.transaction_unique_id
      data.session_id = faker.random.alphaNumeric()
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with invalid profile_current_status parameter', ->
      data = _.clone @data
      data.transaction_status = 'invalid_value'
      assert.isNotTrue @transaction.setData(data).isValid()
