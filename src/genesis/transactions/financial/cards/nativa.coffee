TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class Nativa extends FinancialBase

  getTransactionType: ->
    TransactionTypes.NATIVA

module.exports = Nativa
