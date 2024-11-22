path          = require 'path'
_             = require 'underscore'
faker         = require 'faker'
url           = require 'url'
sinon         = require 'sinon'
Domains       = require path.resolve './src/genesis/constants/domains'
Request       = require path.resolve './src/genesis/request'
Config        = require path.resolve './src/genesis/utils/configuration/config'

describe 'Request', ->

  beforeEach ->

    @conf = {
      customer : {
        "username":            "username",
        "password"           : "123456",
        "token"              : "123456",
        "force_smart_routing": false,
      },
      gateway : {
        "protocol" : "https",
        "hostname" : "emerchantpay.net",
        "timeout"  : "60000",
        "testing"  : true
      },
      notifications : {
        "host"     : "<hostname>",
        "port"     : "<port>",
        "path"     : "<path>"
      }
    };

    @configuration = new Config @conf

    @request = new Request @configuration
    @params =
      url:
        app: faker.random.arrayElement(
          ["gate", "wpf", "smart_router"]
        )
        path: faker.random.word()
        token: faker.random.alphaNumeric()

  it 'formats valid url', ->
    # with token
    request = new Request('xml', @configuration)
    result = url.parse(request.formatUrl @params.url)

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname

    # without token
    result = url.parse(request.formatUrl _.omit @params.url, 'token')

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname

  it 'returns gate string for prod envinroment', ->
    @conf.gateway.testing = false
    request = new Request('xml', (new Config @conf))

    assert.equal 'gate', request.getURLEnvironment('gate')

  it 'returns wpf string for prod envinroment', ->
    @conf.gateway.testing = false
    request = new Request('xml', (new Config @conf))

    assert.equal 'wpf', request.getURLEnvironment('wpf')

  it 'returns prod.api string for prod envinroment', ->
    @conf.gateway.testing = false
    request = new Request('xml', (new Config(@conf)))

    assert.equal 'prod.api', request.getURLEnvironment('smart_router')

  it 'returns staging.gate environment string', ->
    request = new Request('xml', @configuration)

    assert.equal 'staging.gate', request.getURLEnvironment('gate')

  it 'returns staging.wpf environment string', ->
    request = new Request('xml', @configuration)

    assert.equal 'staging.wpf', request.getURLEnvironment('wpf')

  it 'returns staging.api environment string', ->
    request = new Request('xml', @configuration)

    assert.equal 'staging.api', request.getURLEnvironment('smart_router')

  it 'returns staging.api environment string', ->
    request = new Request('xml', @configuration)

    assert.equal 'staging.api', request.getURLEnvironment('smart_router')

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

