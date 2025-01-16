FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Poli extends FinancialBase

  getTransactionType: ->
    TransactionTypes.POLI

module.exports = Poli
