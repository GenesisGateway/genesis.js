
FinancialBase    = require './../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class IncrementalAuthorize extends FinancialBase

  getTransactionType: ->
    TransactionTypes.INCREMENTAL_AUTHORIZE

module.exports = IncrementalAuthorize
