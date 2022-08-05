faker = require 'faker'
_     = require 'underscore'

Moto = () ->

  it 'not fail with moto', ->
    data = _.clone @data
    data = _.extend(data, {"moto": true})
    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with invalid moto', ->
    data = _.clone @data
    data = _.extend(data, {"moto": 'true'})
    assert.equal false, @transaction.setData(data).isValid()

module.exports = Moto
