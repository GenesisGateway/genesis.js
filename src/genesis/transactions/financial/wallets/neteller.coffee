
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Neteller extends FinancialBase

  getTransactionType: ->
    TransactionTypes.NETELLER

module.exports = Neteller
