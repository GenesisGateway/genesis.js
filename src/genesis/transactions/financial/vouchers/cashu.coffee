FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class CashU extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CASHU

  constructor: (params, configuration) ->
    super params, configuration

module.exports = CashU
