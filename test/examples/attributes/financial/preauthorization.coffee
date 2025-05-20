faker = require 'faker'
_     = require 'underscore'

Preauthorization = () ->

  it 'not fail with preauthorization', ->
    data = _.clone @data
    data = _.extend(data, {"preauthorization": true})
    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with invalid preauthorization', ->
    data = _.clone @data
    data = _.extend(data, {"preauthorization": 'invalid'})
    assert.equal false, @transaction.setData(data).isValid()

module.exports = Preauthorization
