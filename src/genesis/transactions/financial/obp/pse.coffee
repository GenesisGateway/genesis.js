FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Pse extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PSE

module.exports = Pse
