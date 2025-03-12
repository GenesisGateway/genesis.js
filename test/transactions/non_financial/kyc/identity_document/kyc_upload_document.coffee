path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/identity_document/kyc_upload_document'

describe 'KYC Upload Document Request', ->

  before ->
    @data = {
      transaction_unique_id: faker.datatype.number().toString()
      method:                faker.random.arrayElement([1, 2, 3])
      doc: {
        base64_content:      faker.random.alphaNumeric()
        mime_type:           "image/jpeg"
      }
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/upload_document'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with reference_id required parameter', ->
      data = _.clone @data
      delete data.transaction_unique_id
      data.reference_id = faker.random.alphaNumeric()
      assert.isTrue @transaction.setData(data).isValid()

    it 'works with all parameters', ->
      data = _.clone @data
      data.customer_username =  faker.internet.userName()
      data.customer_unique_id = faker.random.alphaNumeric()
      doc2: {
        base64_content:      faker.random.alphaNumeric()
        mime_type:           "image/jpeg"
      }
      doc3: {
        base64_content:      faker.random.alphaNumeric()
        mime_type:           "image/jpeg"
      }
      doc4: {
        base64_content:      faker.random.alphaNumeric()
        mime_type:           "image/jpeg"
      }
      assert.isTrue @transaction.setData(data).isValid()

  describe 'when invalid request', ->
    it 'fails with missing required parameters', ->
      data = _.clone @data
      delete data.method
      delete data.doc
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with missing conditionally required parameters', ->
      data = _.clone @data
      delete data.transaction_unique_id
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with invalid method parameter', ->
      data = _.clone @data
      data.method = 'invalid_value'
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with missing required parameters in doc section', ->
      data = _.clone @data
      delete data.doc.mime_type
      assert.isNotTrue @transaction.setData(data).isValid()
