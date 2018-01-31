path  = require 'path'
_     = require 'underscore'
faker = require 'faker'
url   = require 'url'

Request   = require path.resolve './src/genesis/request'

describe 'Request', ->

  before ->
    @request = new Request

  it 'formats valid url', ->
    params =
        app:
          faker.random.word()
        path:
          faker.random.word()
        token:
          faker.random.alphaNumeric()

    # with token
    result = url.parse(@request.formatUrl params)

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname

    # without token
    result = url.parse(@request.formatUrl _.omit params, 'token')

    assert.typeOf result, 'object'
    assert.isNotNull result.hostname
