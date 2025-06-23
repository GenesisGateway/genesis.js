BaseExamples = require '../../base'
FakeConfig   = require '../../fake_config'
Faker        = require 'faker'
Transaction  = require '../../../../src/genesis/transactions/non_financial/payee/create_payee_account'

describe 'Create Payee Account Transaction', ->
  beforeEach ->
    @data =
      payee_unique_id: '123ABC'
      account: {
        type:    'iban'
        number:  Faker.datatype.uuid()
        country: 'US'
      }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'payee/123ABC/account'

    it 'with JSON builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'with proper transaction structure', ->
      expect(@transaction.getArguments().trx).to.have.not.property('payee_unique_id')
    
    it 'with institution_code when type is bank', ->
      @data.account.type             = 'bank'
      @data.account.institution_code = Faker.datatype.uuid()

      assert.isTrue @transaction.setData(@data).isValid()

  describe 'when invalid request', ->
    it 'with missing payee_unique_id', ->
      delete @data.payee_unique_id

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with missing type', ->
      delete @data.account.type

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid type', ->
      @data.account.type = 'invalid'

      assert.isNotTrue @transaction.setData(@data).isValid()
    
    it 'with missing number', ->
      delete @data.account.number

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with missing institution_code when type is bank', ->
      @data.account.type = 'bank'

      assert.isNotTrue @transaction.setData(@data).isValid()
