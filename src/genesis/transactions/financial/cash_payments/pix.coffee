
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Pix extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PIX

module.exports = Pix
