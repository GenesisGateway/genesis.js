FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class CashU extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CASHU

module.exports = CashU
