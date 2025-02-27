Transaction  = require '../../../../src/genesis/transactions/non_financial/fx/tier'
FakeConfig   = require '../../fake_config'
BaseExamples = require '../../base'

describe 'FX Tier API service', ->
  beforeEach ->
    @data        = { id: 123 }
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  it 'when builds request', ->
    assert.isTrue @transaction.isValid()

  it 'with string identifier', ->
    @data.id = '123'

    assert.isTrue @transaction.setData(@data).isValid()

  it 'without identifier', ->
    @data = {}

    assert.isNotTrue @transaction.setData(@data).isValid()

  it 'with proper endpoint url', ->
    assert.equal @transaction.getUrl().path, 'v1/fx/tiers/123'

  it 'with get builder interface', ->
    assert.equal @transaction.builderInterface, 'get'
