FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Upi extends FinancialBase

  getTransactionType: ->
    TransactionTypes.UPI

module.exports = Upi
