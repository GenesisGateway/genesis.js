
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class PayPal extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PAY_PAl

module.exports = PayPal
