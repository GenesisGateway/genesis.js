faker = require 'faker'
_     = require 'underscore'

UCOF = () ->

  it 'works with ucof parameters', ->
    data = _.clone @data
    data = _.extend(data, {
      credential_on_file_transaction_identifier: "MCC242736",
      credential_on_file_settlement_date: "0107"
      }
    )

    assert.equal true, @transaction.setData(data).isValid()

  it 'works without ucof parameters', ->
    data = _.clone @data
    delete data.credential_on_file_transaction_identifier
    delete data.credential_on_file_settlement_date

    assert.equal true, @transaction.setData(data).isValid()

  it 'fails with invalid length of credential_on_file_transaction_identifier', ->
    data = _.clone @data
    data.credential_on_file_transaction_identifier = faker.datatype.string(33)

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails with invalid length of credential_on_file_settlement_date', ->
    data = _.clone @data
    data.credential_on_file_settlement_date = faker.datatype.string(5)

    assert.equal false, @transaction.setData(data).isValid()

module.exports = UCOF
