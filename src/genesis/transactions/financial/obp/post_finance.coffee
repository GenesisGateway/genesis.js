FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class PostFinance extends FinancialBase

  getTransactionType: ->
    TransactionTypes.POST_FINANCE

module.exports = PostFinance
