_      = require 'underscore'
crypto = require 'crypto'
config = require 'config'

class ThreedsUtils

  @generateSignature: (uniqueId, amount, timestamp, password) ->
    crypto.createHash('sha512')
      .update(uniqueId + amount + timestamp + password)
      .digest('hex')

module.exports = ThreedsUtils
