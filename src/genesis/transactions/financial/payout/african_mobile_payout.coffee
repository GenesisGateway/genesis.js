
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class AfricanMobilePayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.AFRICAN_MOBILE_PAYOUT

module.exports = AfricanMobilePayout
