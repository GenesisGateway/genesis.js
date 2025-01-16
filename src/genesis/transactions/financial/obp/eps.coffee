FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Eps extends FinancialBase

  getTransactionType: ->
    TransactionTypes.EPS

module.exports = Eps
