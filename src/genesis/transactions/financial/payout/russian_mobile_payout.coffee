FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class RussianMobilePayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.RUSSIAN_MOBILE_PAYOUT

module.exports = RussianMobilePayout
