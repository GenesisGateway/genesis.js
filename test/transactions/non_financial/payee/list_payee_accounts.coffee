BaseExamples = require '../../base'
FakeConfig   = require '../../fake_config'
Faker        = require 'faker'
Transaction  = require '../../../../src/genesis/transactions/non_financial/payee/list_payee_accounts'

describe 'List Payee Accounts Transaction', ->
  beforeEach ->
    @data =
      payee_unique_id:   '123ABC'

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()
    
    it 'with get builder interface', ->
      assert.equal @transaction.builderInterface, 'get'

    it 'with proper endpoint url with no additional parameters', ->
      assert.equal @transaction.getUrl().path, 'payee/123ABC/account'

    it 'with proper endpoint url with additional number_eq parameter', ->
      @data.number_eq = 'test123'
      transaction = new Transaction(@data, FakeConfig.getConfig())

      assert.equal transaction.getUrl().path, 'payee/123ABC/account/?number_eq=test123'

    it 'with proper endpoint url with additional type_eq parameter', ->
      @data.type_eq = 'test123'
      transaction = new Transaction(@data, FakeConfig.getConfig())

      assert.equal transaction.getUrl().path, 'payee/123ABC/account/?type_eq=test123'

    it 'with proper endpoint url with additional institution_code_eq parameter', ->
      @data.institution_code_eq = 'test123'
      transaction = new Transaction(@data, FakeConfig.getConfig())

      assert.equal transaction.getUrl().path, 'payee/123ABC/account/?institution_code_eq=test123'

    it 'with proper endpoint url with all additional parameters', ->
      @data.number_eq           = param1 = Faker.random.alphaNumeric(5)
      @data.type_eq             = param2 = Faker.random.alphaNumeric(5)
      @data.institution_code_eq = param3 = Faker.random.alphaNumeric(5)

      transaction = new Transaction(@data, FakeConfig.getConfig())
      additional_params = "number_eq=#{encodeURIComponent(param1)}&type_eq=#{encodeURIComponent(param2)}&institution_code_eq=#{encodeURIComponent(param3)}"

      assert.equal transaction.getUrl().path, "payee/123ABC/account/?#{additional_params}"

  describe 'when invalid request', ->
    it 'with missing payee_unique_id', ->
      delete @data.payee_unique_id

      assert.isNotTrue @transaction.setData(@data).isValid()
