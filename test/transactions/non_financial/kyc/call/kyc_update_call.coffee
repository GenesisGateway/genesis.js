path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require path.resolve './src/genesis/transactions/non_financial/kyc/call/kyc_update_call'

describe 'KYC Update Call Request', ->

  before ->
    @data = {
      reference_id:        faker.random.alphaNumeric()
      security_code_input: faker.random.alphaNumeric()
      verification_status: faker.random.arrayElement(["3", "4", "5"])
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/update_authentication'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  describe 'when invalid request', ->
    it 'fails with missing required reference_id parameters', ->
      data = _.clone @data
      delete data.reference_id
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with missing required security_code_input parameters', ->
      data = _.clone @data
      delete data.security_code_input
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with missing required verification_status parameters', ->
      data = _.clone @data
      delete data.verification_status
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with invalid verification_status parameter', ->
      data = _.clone @data
      data.verification_status = '1'
      assert.isNotTrue @transaction.setData(data).isValid()
