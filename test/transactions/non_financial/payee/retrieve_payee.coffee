BaseExamples = require '../../base'
FakeConfig   = require '../../fake_config'
Transaction  = require '../../../../src/genesis/transactions/non_financial/payee/retrieve_payee'

describe 'Retrieve Payee Transaction', ->
  beforeEach ->
    @data = { payee_unique_id: '123ABC' }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'payee/123ABC'

    it 'with get builder interface', ->
      assert.equal @transaction.builderInterface, 'get'
