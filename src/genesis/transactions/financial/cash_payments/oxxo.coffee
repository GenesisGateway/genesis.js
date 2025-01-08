
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Oxxo extends FinancialBase

  getTransactionType: ->
    TransactionTypes.OXXO

module.exports = Oxxo
