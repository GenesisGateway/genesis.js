
FinancialBase    = require './financial_base'
TransactionTypes = require '../../helpers/transaction/types'
_                = require 'underscore'

class Capture extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CAPTURE

module.exports = Capture
