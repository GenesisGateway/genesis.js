FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class MyBank extends FinancialBase

  getTransactionType: ->
    TransactionTypes.MY_BANK

module.exports = MyBank
