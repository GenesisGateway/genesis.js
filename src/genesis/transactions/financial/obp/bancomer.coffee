
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Bancomer extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BANCOMER

module.exports = Bancomer
