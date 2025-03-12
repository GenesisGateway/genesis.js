path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/identity_document/kyc_download_document'

describe 'KYC Download Document Request', ->

  before ->
    @data = {
      identity_document_id: faker.datatype.number().toString()
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/download_document'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  describe 'when invalid request', ->
    it 'fails with missing required parameters', ->
      data = _.clone @data
      delete data.identity_document_id
      assert.isNotTrue @transaction.setData(data).isValid()
