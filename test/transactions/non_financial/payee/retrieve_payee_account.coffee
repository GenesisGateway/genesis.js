BaseExamples = require '../../base'
FakeConfig   = require '../../fake_config'
Transaction  = require '../../../../src/genesis/transactions/non_financial/payee/retrieve_payee_account'

describe 'Retrieve Payee Account Transaction', ->
  beforeEach ->
    @data =
      payee_unique_id:   '123ABC'
      account_unique_id: 'XYZ098'

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'payee/123ABC/account/XYZ098'

    it 'with get builder interface', ->
      assert.equal @transaction.builderInterface, 'get'

  describe 'when invalid request', ->
    it 'with missing payee_unique_id', ->
      delete @data.payee_unique_id

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with missing account_unique_id', ->
      delete @data.account_unique_id

      assert.isNotTrue @transaction.setData(@data).isValid()
