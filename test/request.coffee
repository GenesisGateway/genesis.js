path          = require 'path'
_             = require 'underscore'
faker         = require 'faker'
FakeConfig    = require path.resolve './test/transactions/fake_config'
Request       = require path.resolve './src/genesis/request'
url           = require 'url'

describe 'Request', ->

  beforeEach ->

    @configuration = FakeConfig.getConfig()
    @request = new Request(@params, @configuration)
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
