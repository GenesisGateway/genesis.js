path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/fraud/reports/fraud_report'

describe 'FraudReport Transaction', ->

  before ->
    @data =
      original_transaction_unique_id: faker.random.alphaNumeric()

    @transaction = new Transaction()

  it 'fails when missing required parameter', ->
    assert.equal false, @transaction.setData(
      _.omit @data, 'original_transaction_unique_id'
    ).isValid()

  Base()
