FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Davivienda extends FinancialBase

  getTransactionType: ->
    TransactionTypes.DAVIVIENDA

module.exports = Davivienda
