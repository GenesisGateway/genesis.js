path    = require 'path'
Request = require path.resolve './src/genesis/request'

FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/alternatives/transfer_to/payers'

describe 'Payers Transaction', ->

  beforeEach ->
    @data          = ''
    @transaction   = new Transaction @data, FakeConfig.getConfig()

  it 'with valid request URL', ->

    url = @transaction.getArguments().url
    assert.equal 'transfer_to_payers/payers', url.path

  it 'calls request send method', ->
    try
      send = sinon.stub(Request.prototype, 'send').returns(true)

      @transaction.send()
      sinon.assert.calledOnce(send)
    catch e
      throw e
    finally
      send.restore()

