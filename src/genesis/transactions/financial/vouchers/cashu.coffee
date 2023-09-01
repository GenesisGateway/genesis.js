FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class CashU extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CASHU

  constructor: (params) ->
    super params

module.exports = CashU
