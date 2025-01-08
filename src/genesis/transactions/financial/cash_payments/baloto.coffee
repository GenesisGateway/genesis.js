
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Baloto extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BALOTO

module.exports = Baloto
