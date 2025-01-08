
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'

class IDebitPayin extends FinancialBase

  getTransactionType: ->
    TransactionTypes.IDEBIT_PAYIN

module.exports = IDebitPayin
