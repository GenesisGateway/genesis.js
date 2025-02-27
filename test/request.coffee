path       = require 'path'
FakeConfig = require path.resolve './test/transactions/fake_config'
Request    = require path.resolve './src/genesis/request'
Network    = require '../src/genesis/networks/axios_api'
Promise    = require 'bluebird'
Validator  = require '../src/genesis/transactions/validator'

describe 'Request', ->

  beforeEach ->
    @config = FakeConfig.getConfig()

    @networkDoRequest = sinon.stub(Network.prototype, 'doRequest').returns(Promise.resolve('Gateway Response'))
    sinon.stub(Request.prototype, 'getUrl').returns(
      {
        app:  'gate',
        path: 'fake',
        token: @config.getCustomerToken()
      }
    )
    @params  = { }
    sinon.stub(Request.prototype, 'getTrxData').returns(@params)

    @request = new Request(@params, @config)
    @request.network = new Network()

  afterEach ->
    sinon.verifyAndRestore()

  it 'when format url with token', ->
    assert.equal(
      @request.formatUrl(@request.getArguments().url),
      "https://staging.gate.#{@config.getGatewayHostname()}/fake/#{@config.getCustomerToken()}"
    )

  it 'when format url without token', ->
    args = @request.getArguments().url
    delete args.token

    assert.equal(
      @request.formatUrl(args),
      "https://staging.gate.#{@config.getGatewayHostname()}/fake"
    )

  it 'when getUrl with proper structure', ->
    expect(@request.getUrl()).to.have.property('app')
    expect(@request.getUrl()).to.have.property('path')
    expect(@request.getUrl()).to.have.property('token')

  it 'when getArguments with proper structure', ->
    assert.deepEqual @request.getArguments(), { trx: {}, url: @request.getUrl() }

  it 'when getArguments with only exact one call', ->
    sinon.stub(Request.prototype, 'isValid').returns(true)
    requestGetArguments = sinon.spy(Request.prototype, 'getArguments')

    @request.send()

    expect(requestGetArguments).to.be.calledOnce

  it 'when getTrxData base implementation', ->
    assert.deepEqual @request.getTrxData(), {}

  it 'when XML interface load Proper builder', ->
    @request = new Request(@params, @config, 'xml')

    expect(@request.initConfiguration()).to.have.nested.property('method')
    assert.equal @request.initConfiguration().method, 'POST'
    expect(@request.initConfiguration()).to.have.nested.property('headers')
    expect(@request.initConfiguration()).to.have.nested.property('timeout')
    assert.equal @request.initConfiguration().headers['Content-Type'], 'text/xml'

  it 'when JSON interface load Proper builder', ->
    @request = new Request(@params, @config, 'json')

    expect(@request.initConfiguration()).to.have.nested.property('method')
    assert.equal @request.initConfiguration().method, 'POST'
    expect(@request.initConfiguration()).to.have.nested.property('headers')
    expect(@request.initConfiguration()).to.have.nested.property('timeout')
    assert.equal @request.initConfiguration().headers['Content-Type'], 'application/json'

  it 'when FORM interface load Proper builder', ->
    @request = new Request(@params, @config, 'form')

    expect(@request.initConfiguration()).to.have.nested.property('method')
    assert.equal @request.initConfiguration().method, 'PUT'
    expect(@request.initConfiguration()).to.have.nested.property('headers')
    expect(@request.initConfiguration()).to.have.nested.property('timeout')
    assert.equal @request.initConfiguration().headers['Content-Type'], 'application/x-www-form-urlencoded'

  it 'when Get interface load Proper builder', ->
    @request = new Request(@params, @config, 'get')

    expect(@request.initConfiguration()).to.have.nested.property('method')
    assert.equal @request.initConfiguration().method, 'GET'
    expect(@request.initConfiguration()).to.have.nested.property('headers')
    expect(@request.initConfiguration()).to.have.nested.property('timeout')
    expect(@request.initConfiguration().headers).to.not.have.nested.property('Content-Type')

  it 'when validate request with invalid params', ->
    assert.isNotTrue @request.isValid()

  it 'when valid request with parameter sanitization', ->
    sinon.stub(Validator.prototype, 'isValidConfig').returns true
    requestSanitizeParams = sinon.spy(Request.prototype, 'sanitizeParams')

    @request = new Request(@params, @config)
    @request.network = new Network()
    @request.validator = new Validator(@request)

    @request.isValid()

    expect(requestSanitizeParams).to.have.been.calledOnce

  it 'when sanitizeParams with empty values', ->
    @params = {
      payment_transaction: { param1: 'value1', param2: '', param3: 'value3', param4: null, param5: undefined }
    }

    @request.sanitizeParams(@params)

    assert.deepEqual @params, { payment_transaction: { param1: 'value1', param3: 'value3' } }

  it 'when getErrors', ->
    @request.isValid()

    assert.deepEqual @request.getErrors(), [ { message: 'JSON schema not found for this request' } ]

  it 'when Validation Error Response', ->
    @request.isValid()

    assert.deepEqual @request.getValidationErrorResponse(), {
      status: 'INVALID_INPUT',
      message: 'Please verify the transaction parameters and check input data for errors.',
      response: [ { message: 'JSON schema not found for this request' } ]
    }

  it 'when send the request with prepareNetwork', ->
    sinon.stub(Request.prototype, 'isValid').returns(true)
    prepareConfigSpy = sinon.spy(Network.prototype, 'prepareConfig')

    @request.send()

    assert.isTrue prepareConfigSpy.calledWith(@request.initConfiguration())

  it 'when send request with success validation with resolved promise', ->
    sinon.stub(Request.prototype, 'isValid').returns(true)

    @request.send()
      .then((data) ->
        assert.equal data, 'Gateway Response'
    ).catch((error) ->
      throw Error('Test case do not expect invalid Request!')
    )

  it 'when send request with success validation with rejected promise', ->
    sinon.stub(Request.prototype, 'isValid').returns(true)
    @networkDoRequest.restore()
    sinon.stub(Network.prototype, 'doRequest').returns(Promise.reject('Gateway Error'))
    @request.network = new Network()

    @request.send()
      .then((data) ->
        throw Error('Test case do not expect valid Request!')
    ).catch((error) ->
      assert.equal error, 'Gateway Error'
    )

  it 'when send request with failure validation with promise', ->
    @request.send()
      .then((data) ->
        throw Error('Test case do not expect invalid Request!')
    ).catch((error) ->
      assert.deepEqual error, {
        status: 'INVALID_INPUT',
        message: 'Please verify the transaction parameters and check input data for errors.',
        response: [ { message: 'JSON schema not found for this request' } ]
      }
    )

  it 'when getDefaultNetworkOptions with proper structure', ->
    expect(@request.getDefaultNetworkOptions()).to.have.property('headers')
    expect(@request.getDefaultNetworkOptions().headers['User-Agent'])
      .to.equal("Genesis Node.js client v#{@config.getVersion()}")
    expect(@request.getDefaultNetworkOptions().headers['Authorization']).to.equal(@request.getAuthorizationHeader())
    expect(@request.getDefaultNetworkOptions()['timeout']).to.equal(@config.getGatewayTimeout())

  it 'when getAuthorizationHeader with proper value', ->
    credentials = "#{@config.getCustomerUsername()}:#{@config.getCustomerPassword()}"

    assert.equal @request.getAuthorizationHeader(), "Basic #{Buffer.from(credentials).toString('base64')}"
