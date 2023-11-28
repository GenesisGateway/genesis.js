FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'

class OnlineBankingPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.ONLINE_BANKING_PAYOUT


module.exports = OnlineBankingPayout
