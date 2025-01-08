FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Bradesco extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BRADESCO

module.exports = Bradesco
