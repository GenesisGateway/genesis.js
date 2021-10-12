path  = require 'path'
_     = require 'underscore'
faker = require 'faker'
url   = require 'url'
config   = require 'config'

Request   = require path.resolve './src/genesis/request'

describe 'Request', ->

  before ->
    @request = new Request
    @params =
      app: faker.random.word()
      path: faker.random.word()
      token: faker.random.alphaNumeric()

  it 'formats valid url', ->
    params = _.clone @params
    # with token
    result = url.parse(@request.formatUrl params)

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname

    # without token
    result = url.parse(@request.formatUrl _.omit params, 'token')

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname

  it 'returns empty string for prod envinroment', ->
    config.gateway.testing = false

    assert.equal '', @request.getURLEnvironment()

  it 'returns staging environment string', ->
    config.gateway.testing = true

    assert.equal 'staging.', @request.getURLEnvironment()
