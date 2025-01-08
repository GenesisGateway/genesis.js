
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'

class IDebitPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.IDEBIT_PAYOUT

module.exports = IDebitPayout
