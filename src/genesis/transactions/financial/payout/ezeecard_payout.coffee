FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class EzeeCardPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.EZEECARD_PAYOUT

module.exports = EzeeCardPayout
