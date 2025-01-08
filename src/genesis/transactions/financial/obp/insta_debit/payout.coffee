
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'

class InstaDebitPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.INSTA_DEBIT_PAYOUT

module.exports = InstaDebitPayout
