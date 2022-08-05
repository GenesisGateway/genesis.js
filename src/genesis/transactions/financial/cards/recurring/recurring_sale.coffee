
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'

class RecurringSale extends FinancialBase

  getTransactionType: ->
    TransactionTypes.RECURRING_SALE

  constructor: (params) ->
    super params

module.exports = RecurringSale
