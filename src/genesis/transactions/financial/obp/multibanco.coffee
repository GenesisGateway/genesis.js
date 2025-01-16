FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Multibanco extends FinancialBase

  getTransactionType: ->
    TransactionTypes.MULTIBANCO

module.exports = Multibanco
