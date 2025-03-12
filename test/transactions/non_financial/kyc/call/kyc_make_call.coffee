path  = require 'path'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require path.resolve './src/genesis/transactions/non_financial/kyc/call/kyc_make_call'

describe 'KYC Make Call Request', ->

  beforeEach ->
    @data = {
      transaction_unique_id: faker.datatype.number().toString()
      customer_phone_number: faker.phone.phoneNumber()
      service_language:      faker.random.arrayElement(
        ["a", "zh-HK", "ca", "hr", "cs", "da", "nl", "en-AU", "en-GB", "en-US", "et", "fil", "fi", "fr",
        "fr-CA", "de", "el", "he", "hi", "hu", "is", "id", "it", "ja", "ko", "lv", "ln", "lt", "zh-CN", "no",
        "pl", "pt-BR", "pt", "ro", "ru", "sk", "es", "es-419", "sv", "th", "tr", "uk", "vi"]
      )
      security_code:         faker.datatype.number({ min: 1000, max: 9999}).toString()
      service_type:          faker.random.arrayElement([1, 2])
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'when invalid request', ->
    it 'fails with missing required transaction_unique_id parameter', ->
      delete @data.transaction_unique_id
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required customer_phone_number parameter', ->
      delete @data.customer_phone_number
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required service_language parameter', ->
      delete @data.service_language
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required security_code parameter', ->
      delete @data.security_code
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required service_type parameter', ->
      delete @data.service_type
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid security_code parameter', ->
      @data.security_code = faker.datatype.number({ min: 10000, max: 99999}).toString()
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid service_language parameter', ->
      @data.service_language = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid service_type parameter', ->
      @data.service_type = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

  context 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/create_authentication'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with all parameters', ->
      @data.customer_username =  faker.internet.userName()
      @data.customer_unique_id = faker.random.alphaNumeric()
      assert.isTrue @transaction.setData(@data).isValid()
