path   = require 'path'
_      = require 'underscore'
faker  = require 'faker'
url    = require 'url'
config = require 'config'
sinon  = require 'sinon'
Domains   = require path.resolve './src/genesis/constants/domains'
Request   = require path.resolve './src/genesis/request'

describe 'Request', ->

  beforeEach ->
    @request = new Request
    @params =
      url:
        app: faker.random.arrayElement(
          ["gate", "wpf", "smart_router"]
        )
        path: faker.random.word()
        token: faker.random.alphaNumeric()

  it 'formats valid url', ->
    # with token
    result = url.parse(@request.formatUrl @params.url)

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname

    # without token
    result = url.parse(@request.formatUrl _.omit @params.url, 'token')

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname

  it 'returns gate string for prod envinroment', ->
    config.gateway.testing = false

    assert.equal 'gate', @request.getURLEnvironment('gate')

  it 'returns wpf string for prod envinroment', ->
    config.gateway.testing = false

    assert.equal 'wpf', @request.getURLEnvironment('wpf')

  it 'returns prod.api string for prod envinroment', ->
    config.gateway.testing = false

    assert.equal 'prod.api', @request.getURLEnvironment('smart_router')

  it 'returns staging.gate environment string', ->
    config.gateway.testing = true

    assert.equal 'staging.gate', @request.getURLEnvironment('gate')

  it 'returns staging.wpf environment string', ->
    config.gateway.testing = true

    assert.equal 'staging.wpf', @request.getURLEnvironment('wpf')

  it 'returns staging.api environment string', ->
    config.gateway.testing = true

    assert.equal 'staging.api', @request.getURLEnvironment('smart_router')

  it 'returns staging.api environment string', ->
    config.gateway.testing = true

    assert.equal 'staging.api', @request.getURLEnvironment('smart_router')

  it 'returns true when app exists', ->
    @params.url.app = "gate"

    assert.equal true, @request.validateConfiguration(@params.url.app)

  it 'returns specific object when app not exists', ->
    @params.url.app = "fake"

    assert.deepEqual @request.getEnvironmentErrorMessage(), @request.validateConfiguration(@params.url.app)

  it 'returns object when non-existent object given', ->
    result = @request.validateConfiguration('fake')

    assert.typeOf result, 'object'

  it 'when invalid app with proper response', ->
    @params.url.app = "fake"
    sinon.stub(@request, 'getUrl').returns(@params.url)
    output = @request.getEnvironmentErrorMessage()

    @request
      .send()
      .then (reason) ->
        throw new Error('Not expected to send')
      .catch (reason) ->
        assert.deepEqual reason, output
