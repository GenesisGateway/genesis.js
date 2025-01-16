TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class Argencard extends FinancialBase

  getTransactionType: ->
    TransactionTypes.ARGENCARD

module.exports = Argencard
