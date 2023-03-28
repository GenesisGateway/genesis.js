path  = require 'path'
_     = require 'underscore'

FakeData    = require '../fake_data'
Transaction = require path.resolve './src/genesis/transactions/non_financial/account_verification'
Base        = require '../base'
Moto        = require '../../examples/attributes/financial/moto'
RiskParams  = require '../../examples/attributes/risk_params'

describe 'AccountVerification Transaction', ->

  before ->
    @data        = (new FakeData).getData()

    delete @data['amount']
    delete @data['currency']

    @transaction = new Transaction()

  Base()
  Moto()
  RiskParams()
