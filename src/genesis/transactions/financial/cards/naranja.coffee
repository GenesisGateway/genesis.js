TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class Naranja extends FinancialBase

  getTransactionType: ->
    TransactionTypes.NARANJA

module.exports = Naranja
