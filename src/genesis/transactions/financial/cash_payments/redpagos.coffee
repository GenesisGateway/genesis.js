
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Redpagos extends FinancialBase

  getTransactionType: ->
    TransactionTypes.REDPAGOS

module.exports = Redpagos
