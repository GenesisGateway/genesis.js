AxiosNetwork     = require '../../src/genesis/networks/axios_api'
BaseRequestApi   = require '../../src/genesis/networks/base_request_api'
{ AxiosHeaders } = require 'axios'
https            = require 'https'
axios            = require 'axios'

describe 'Axios Network', ->
  beforeEach ->
    @axiosHeaders            = new AxiosHeaders({ 'content-type': 'text/xml' })
    @network                 = new AxiosNetwork()
    @network.responseHeaders = @axiosHeaders

    @data = '<?xml version=\'1.0\'?><param1>value1</param1>'
    @networkObject = {
      data:    @data,
      headers: new AxiosHeaders({ property: 'value', 'content-type': 'app/type' }),
      status:  '200'
    }

    @axiosStub = sinon.stub(axios, 'get').resolves(@networkObject)
    @network.instance = @axiosStub

  afterEach ->
    sinon.verifyAndRestore()

  it 'when initialized', ->
    assert.instanceOf @network, BaseRequestApi

  it 'when response body with default value', ->
    assert.equal @network.getResponseBody(), ''

  it 'when response headers with axios headers', ->
    assert.deepEqual @network.getResponseHeaders(), { 'content-type': 'text/xml' }

  it 'when response headers with default value', ->
    sinon.verifyAndRestore()
    @network = new AxiosNetwork()

    assert.deepEqual @network.getResponseHeaders(), {}

  it 'when response content type with axios headers', ->
    assert.equal @network.getResponseContentType(), 'text/xml'

  it 'when response content type with default value', ->
    sinon.verifyAndRestore()
    @network = new AxiosNetwork()

    assert.equal @network.getResponseContentType(), ''

  it 'when init network with Axios response data', ->
    @network.initNetwork(@networkObject)

    assert.equal @network.getResponseBody(), @data
    assert.deepEqual @network.getResponseHeaders(), { property: 'value', 'content-type': 'app/type' }
    assert.notInstanceOf @network.getResponseHeaders(), AxiosHeaders
    assert.equal @network.getResponseContentType(), 'app/type'
    assert.equal @network.getResponseStatus(), 200

  it 'when prepare config with default options', ->
    @network.prepareConfig({})

    assert.isObject @network.networkConfig
    assert.instanceOf @network.networkConfig.httpsAgent, https.Agent
    assert.equal @network.networkConfig.responseType, 'text'
    assert.isTrue @network.networkConfig.validateStatus(200)

  it 'when prepare request data with proper structure', ->
    requestData = @network.prepareRequestData('https://example.url', { param1: 'value1'})

    assert.isObject requestData
    expect(requestData).to.have.property('url')
    expect(requestData).to.have.property('data')

  it 'when send request', ->
    @network.send('https://some.url', {}).then(
      (data) ->
        assert.deepEqual data, { param1: 'value1' }
    ).catch((error) ->
      throw Error('Test case do not expect invalid Request!')
    )
