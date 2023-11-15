faker = require 'faker'
_     = require 'underscore'

ClientSideEncription = () ->

  it 'works invalid cc params and client_side_encryption to true', ->
    data = _.clone @data
    data.client_side_encryption = true
    data.card_holder = "NOT_VALID_CARD_HOLDER"
    data.card_number = "NOT_VALID_CARD_HOLDER"
    data.expiration_month = "NOT_VALID_MONTH"
    data.expiration_year = "NOT_VALID_YEAR"
    data.cvv = "NOT_VALID_CVV"

    assert.equal true, @transaction.setData(data).isValid()

  it 'works valid cc params and client_side_encryption to false', ->
    data = _.clone @data
    data.client_side_encryption = false

    assert.equal true, @transaction.setData(data).isValid()

  it 'works valid cc params and client_side_encryption to true', ->
    data = _.clone @data
    data.client_side_encryption = true

    assert.equal true, @transaction.setData(data).isValid()


  it 'fails with invalid cc params and client_side_encryption to false', ->
    data = _.clone @data
    data.client_side_encryption = false
    data.card_holder = "NOT_VALID_CARD_HOLDER"
    data.card_number = "NOT_VALID_CARD_HOLDER"
    data.expiration_month = "NOT_VALID_MONTH"
    data.expiration_year = "NOT_VALID_YEAR"
    data.cvv = "NOT_VALID_CVV"

    assert.equal false, @transaction.setData(data).isValid()

module.exports = ClientSideEncription
