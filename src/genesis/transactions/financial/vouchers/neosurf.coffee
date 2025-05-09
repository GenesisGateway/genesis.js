FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Neosurf extends FinancialBase

  getTransactionType: ->
    TransactionTypes.NEOSURF

module.exports = Neosurf
