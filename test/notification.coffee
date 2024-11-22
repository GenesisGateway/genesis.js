path                = require 'path'
_                   = require 'underscore'
faker               = require 'faker'
url                 = require 'url'
config              = require 'config'
Config              = require path.resolve './src/genesis/utils/configuration/config'

Notification   = require path.resolve './src/genesis/notification'

describe 'Notification', ->

  beforeEach ->

    confData = {
      customer : {
        "username":            "username",
        "password"           : "123456",
        "token"              : "token",
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

    @notification = new Notification(confData)

  it 'works with valid signature of 40 symbols', ->

    params =
      signature: '8aa51f70e3773c2f88d615855acb593d12d7b07f'
      unique_id: '44177a21403427eb96664a6d7e5d5d48'

    assert.equal true, @notification.verifySignature(params)

  it 'works with valid signature of 64 symbols', ->

    params =
      signature: '9cf4dc63154666b22f3dd41fe6ca916f8fc65228ecbaeae45679c250110cae20'
      unique_id: '0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33'

    assert.equal true, @notification.verifySignature(params)

  it 'works with valid signature of 128 symbols', ->
    signature = '83668773d35b940585c0aaad03e2e9901a0b50f94890d9eb3558e3fb611f8aba26' +
                '113434c3d72e30e76f6b90a850d4e20281160f0a4e31fa598982c745019762'

    params =
      signature: signature
      unique_id: 'a459f8781f2fe14a6e787648c146be02'

    assert.equal true, @notification.verifySignature(params)

  it 'fails with invalid signature of 40 symbols', ->

    params =
      signature: faker.random.alpha(40)
      unique_id: '44177a21403427eb96664a6d7e5d5d48'

    assert.equal false, @notification.verifySignature(params)

  it 'fails with invalid signature of 64 symbols', ->

    params =
      signature: faker.random.alpha(64)
      unique_id: '0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33'

    assert.equal false, @notification.verifySignature(params)

  it 'fails with invalid signature of 128 symbols', ->

    params =
      signature: faker.random.alpha(128)
      unique_id: 'a459f8781f2fe14a6e787648c146be02'

    assert.equal false, @notification.verifySignature(params)
