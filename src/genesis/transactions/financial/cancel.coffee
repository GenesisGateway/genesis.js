
FinancialBase    = require './financial_base'
TransactionTypes = require '../../helpers/transaction/types'

class Cancel extends FinancialBase

  getTransactionType: ->
    TransactionTypes.VOID

  constructor: (params, configuration) ->
    super params, configuration

module.exports = Cancel
