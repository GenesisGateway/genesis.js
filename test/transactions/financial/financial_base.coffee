Base = require '../base'
_    = require 'underscore'

FinancialBase = () ->

  it 'fails when missing required transaction_id parameter', ->
    data = _.clone(@data)
    delete data.transaction_id
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing required amount parameter', ->
    data = _.clone(@data)
    delete data.amount
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing required currency parameter', ->
    data = _.clone(@data)
    delete data.currency
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong amount parameter', ->
    data = _.clone @data
    data.amount = -1000
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fail with integer amount parameter', ->
    data = _.clone @data
    data['amount'] = 100
    assert.equal true, @transaction.setData(data).isValid()

  it 'not fail with number amount parameter', ->
    data = _.clone @data
    data['amount'] = 1.11
    assert.equal true, @transaction.setData(data).isValid()

  it 'not fail with string amount parameter', ->
    data = _.clone @data
    data['amount'] = "1.11"
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when wrong currency parameter', ->
    data = _.clone @data
    data['currency'] = 'NOT_VALID_CURRENCY'
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fail with zero amount', ->
    data = _.clone @data
    data['amount'] = 0

    assert.equal true, @transaction.setData(data).isValid()

  Base()

module.exports = FinancialBase
