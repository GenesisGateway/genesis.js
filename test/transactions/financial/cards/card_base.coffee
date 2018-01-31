FinancialBase = require '../financial_base'
_    = require 'underscore'

CardBase = () ->

  FinancialBase()

  it 'fails when missing required card_holder parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'card_holder').isValid()

  it 'fails when missing required card_number parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'card_number').isValid()

  it 'fails when missing required expiration_month parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'expiration_month').isValid()

  it 'fails when missing required expiration_year parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'expiration_year').isValid()

  it 'fails when wrong card_holder parameter', ->
    data = _.clone @data
    data.card_holder = 'NOT_VALID_CARD_HOLDER'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong card_number parameter', ->
    data = _.clone @data
    data.card_number = 'NOT_VALID_CARD_NUMBER'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong expiration_month parameter', ->
    data = _.clone @data
    data.expiration_month = 'NOT_VALID_EXPIRATION_MONTH'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong expiration_year parameter', ->
    data = _.clone @data
    data.expiration_year = 'NOT_VALID_EXPIRATION_YEAR'
    assert.equal false, @transaction.setData(data).isValid()

module.exports = CardBase