BaseExamples = require '../../base'
FakeConfig   = require '../../fake_config'
Faker        = require 'faker'
Transaction  = require '../../../../src/genesis/transactions/non_financial/payee/create_payee'

describe 'Create Payee Transaction', ->
  beforeEach ->
    @data =
      type:    Faker.random.arrayElement(["company", "person"])
      name:    Faker.name.findName()
      country: 'DE'

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'payee'

    it 'with JSON builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

  describe 'when invalid request', ->
    it 'with missing type', ->
      delete @data.type

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid type', ->
      @data.type = 'invalid'

      assert.isNotTrue @transaction.setData(@data).isValid()
    
    it 'with missing name', ->
      delete @data.name

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with missing country', ->
      delete @data.country

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid country', ->
      @data.type = 'Germany'

      assert.isNotTrue @transaction.setData(@data).isValid()
