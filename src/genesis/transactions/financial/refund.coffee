
FinancialBase    = require './financial_base'
TransactionTypes = require '../../helpers/transaction/types'
_                = require 'underscore'

class Refund extends FinancialBase

  getTransactionType: ->
    TransactionTypes.REFUND

module.exports = Refund
