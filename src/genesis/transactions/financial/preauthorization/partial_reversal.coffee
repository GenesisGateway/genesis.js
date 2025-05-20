FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class PartialReversal extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PARTIAL_REVERSAL

module.exports = PartialReversal
