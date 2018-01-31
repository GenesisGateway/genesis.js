path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Transaction = require path.resolve './src/genesis/transactions/non_financial/fraud/reports/fraud_report'
Base        = require '../../../base'

describe 'FraudReport Transaction', ->

  before ->
    @data =
      arn: faker.random.alphaNumeric()

    @transaction = new Transaction()

  it 'fails when missing required parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'arn').isValid()

  Base()
