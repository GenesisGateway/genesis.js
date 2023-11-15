_      = require 'underscore'
crypto = require 'crypto'
config = require 'config'

class ThreedsUtils

  @generateSignature: (uniqueId, amount, timestamp) ->
    crypto.createHash('sha512')
      .update(uniqueId + amount + timestamp + config.customer.password)
      .digest('hex')

module.exports = ThreedsUtils
