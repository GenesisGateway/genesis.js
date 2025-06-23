FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

###
  Global Payout is a transaction type based on Open Banking APIs, used for initiating bank payments
###
class GlobalPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.GLOBAL_PAYOUT

module.exports = GlobalPayout
