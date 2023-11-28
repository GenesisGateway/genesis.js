FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'

class OnlineBankingPayin extends FinancialBase

  getTransactionType: ->
    TransactionTypes.ONLINE_BANKING_PAYIN

module.exports = OnlineBankingPayin
