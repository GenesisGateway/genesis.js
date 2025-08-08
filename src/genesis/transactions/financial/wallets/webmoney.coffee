
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class WebMoney extends FinancialBase

  getTransactionType: ->
    TransactionTypes.WEBMONEY

module.exports = WebMoney
