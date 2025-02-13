path     = require 'path'
faker    = require 'faker'
_        = require 'underscore'
Config   = require path.resolve './src/genesis/utils/configuration/config'

class FakeConfig

  @getConfig: ->
    new Config @getConfigData()

  @getConfigData: ->
    'customer':
      'username':
        faker.random.alpha(40)
      'password':
        faker.random.alpha(40)
      'token':
        faker.random.alpha(40)
      'force_smart_routing':
        false
    'gateway':
      'protocol':
        'https'
      'hostname':
        faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net'])
      'timeout':
        '60000'
      'testing':
        true
    'notifications':
      'host':
        '<hostname>'
      'port':
        '<port>'
      'path':
        '<path>'

module.exports = FakeConfig
