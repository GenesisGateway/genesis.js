faker = require 'faker'
_     = require 'underscore'

Gaming = () ->

  it 'not fail with gaming', ->
    data = _.clone @data
    data = _.extend(data, {"gaming": true})
    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with invalid gaming', ->
    data = _.clone @data
    data = _.extend(data, {"gaming": 'true'})
    assert.equal false, @transaction.setData(data).isValid()

module.exports = Gaming
