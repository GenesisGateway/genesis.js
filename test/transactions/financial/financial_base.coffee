Base = require '../base'
_    = require 'underscore'

FinancialBase = () ->

  it 'fails when missing required transaction_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'transaction_id').isValid()

  it 'fails when missing required amount parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'amount').isValid()

  it 'fails when missing required currency parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'currency').isValid()

  it 'fails when wrong amount parameter', ->
    data = _.clone @data
    data.amount = -1000
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong currency parameter', ->
    data = _.clone @data
    data.currency = 'NOT_VALID_CURRENCY'
    assert.equal false, @transaction.setData(data).isValid()

  Base()

module.exports = FinancialBase