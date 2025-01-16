TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class Cencosud extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CENCOSUD

module.exports = Cencosud
