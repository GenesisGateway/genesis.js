Transaction  = require '../../../../src/genesis/transactions/non_financial/fx/search_rate'
FakeConfig   = require '../../fake_config'
BaseExamples = require '../../base'

describe 'FX Search Rate API service', ->
  beforeEach ->
    @data        = { tier_id: 123, source_currency: 'EUR', target_currency: 'USD' }
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'when tier_id with string value', ->
      @data.tier_id = '123'

      assert.isTrue @transaction.setData(@data).isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'v1/fx/tiers/123/rates/search'

    it 'with JSON builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'with proper transaction structure', ->
      expect(@transaction.getArguments().trx).to.have.not.property('tier_id')
      expect(@transaction.getArguments().trx).to.have.property('source_currency')
      expect(@transaction.getArguments().trx).to.have.property('target_currency')

  describe 'when invalid request', ->
    it 'without tier_id', ->
      delete @data.tier_id

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without source_currency', ->
      delete @data.source_currency

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without target_currency', ->
      delete @data.target_currency

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid source currency', ->
      @data.source_currency = 'AAA'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid target currency', ->
      @data.target_currency = 'AAA'

      assert.isNotTrue @transaction.setData(@data).isValid()
