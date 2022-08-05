faker = require 'faker'
_     = require 'underscore'

Crypto = () ->

  it 'not fail with crypto', ->
    data = _.clone @data
    data = _.extend(data, {"crypto": true})
    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with invalid gaming', ->
    data = _.clone @data
    data = _.extend(data, {"crypto": 'true'})
    assert.equal false, @transaction.setData(data).isValid()

module.exports = Crypto
