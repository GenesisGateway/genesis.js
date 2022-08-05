
FinancialBase    = require './financial_base'
TransactionTypes = require '../../helpers/transaction/types'

class Cancel extends FinancialBase

  getTransactionType: ->
    TransactionTypes.VOID

  constructor: (params) ->
    super params

module.exports = Cancel
