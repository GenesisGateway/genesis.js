Transaction  = require '../../../../src/genesis/transactions/non_financial/fx/rate'
FakeConfig   = require '../../fake_config'
BaseExamples = require '../../base'

describe 'FX Rate API service', ->
  beforeEach ->
    @data        = { id: 123, tier_id: 123 }
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  it 'when builds request', ->
    assert.isTrue @transaction.isValid()

  it 'when tier_id with string value', ->
    @data.tier_id = '123'

    assert.isTrue @transaction.setData(@data).isValid()

  it 'when id with string value', ->
    @data.id = '123'

    assert.isTrue @transaction.setData(@data).isValid()

  it 'when missing id with invalid validation', ->
    delete @data.id
    
    assert.isNotTrue @transaction.setData(@data).isValid()

  it 'when missing tier_id with invalid validation', ->
    delete @data.tier_id

    assert.isNotTrue @transaction.setData(@data).isValid()

  it 'without identifiers', ->
    @data = {}

    assert.isNotTrue @transaction.setData(@data).isValid()

  it 'with proper endpoint url', ->
    assert.equal @transaction.getUrl().path, 'v1/fx/tiers/123/rates/123'

  it 'with get builder interface', ->
    assert.equal @transaction.builderInterface, 'get'
