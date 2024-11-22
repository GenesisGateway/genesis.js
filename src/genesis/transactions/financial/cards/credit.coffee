
FinancialBase    = require '../financial_base'
_                = require 'underscore'
TransactionTypes = require '../../../helpers/transaction/types'

class Credit extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CREDIT

  constructor: (params, configuration) ->
    super params, configuration

module.exports = Credit
