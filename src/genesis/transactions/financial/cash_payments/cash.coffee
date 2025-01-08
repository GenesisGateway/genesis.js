
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Cash extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CASH

module.exports = Cash
