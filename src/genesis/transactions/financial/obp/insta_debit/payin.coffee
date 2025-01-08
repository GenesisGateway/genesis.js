
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'

class InstaDebitPayin extends FinancialBase

  getTransactionType: ->
    TransactionTypes.INSTA_DEBIT_PAYIN

module.exports = InstaDebitPayin
