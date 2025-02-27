sinon        = require 'sinon'
Transaction  = require '../../../../src/genesis/transactions/non_financial/fx/tiers'
FakeConfig   = require '../../fake_config'
Request      = require '../../../../src/genesis/request'

describe 'FX Tiers API service', ->
  beforeEach ->
    @data        = null
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'when builds request', ->
    assert.isTrue @transaction.isValid()

  it 'without additional parameters', ->
    @data = { param: 'value'}

    assert.isNotTrue @transaction.setData(@data).isValid()

  it 'with proper endpoint url', ->
    assert.equal @transaction.getUrl().path, 'v1/fx/tiers'

  it 'with get builder interface', ->
    assert.equal @transaction.builderInterface, 'get'

  it 'when send request', ->
    try
      send = sinon.stub(Request.prototype, 'send').returns(true)

      @transaction.setData(@data).send()

      sinon.assert.calledOnce(send)
    catch e
      throw e
    finally
      send.restore()
