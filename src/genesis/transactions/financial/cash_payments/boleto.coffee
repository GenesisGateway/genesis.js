
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Boleto extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BOLETO

module.exports = Boleto
