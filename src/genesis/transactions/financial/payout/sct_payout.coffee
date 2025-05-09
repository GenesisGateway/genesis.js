FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class SctPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.SCT_PAYOUT

module.exports = SctPayout
