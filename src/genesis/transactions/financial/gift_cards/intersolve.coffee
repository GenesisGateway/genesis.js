
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Intersolve extends FinancialBase

  getTransactionType: ->
    TransactionTypes.INTERSOLVE

module.exports = Intersolve
