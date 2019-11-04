path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
Transaction = require(
  path.resolve './src/genesis/transactions/non_financial/fraud/chargeback/chargeback_by_date'
)

describe 'FraudReportByDate Transaction', ->

  before ->
    @data =
      start_date:
        '2018-02-13'
      end_date:
        '2017-02-28'
      page:
        1

    @transaction = new Transaction()

  it 'fails when missing required start_date parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'start_date').isValid()

  Base()