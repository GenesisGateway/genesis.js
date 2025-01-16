FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Itau extends FinancialBase

  getTransactionType: ->
    TransactionTypes.ITAU

module.exports = Itau
