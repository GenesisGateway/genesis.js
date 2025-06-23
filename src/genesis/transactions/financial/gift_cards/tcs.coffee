
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Tcs extends FinancialBase

  getTransactionType: ->
    TransactionTypes.TCS

module.exports = Tcs
