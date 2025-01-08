
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Efecty extends FinancialBase

  getTransactionType: ->
    TransactionTypes.EFECTY

module.exports = Efecty
