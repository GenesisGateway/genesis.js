FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Ideal extends FinancialBase

  getTransactionType: ->
    TransactionTypes.IDEAL

module.exports = Ideal
