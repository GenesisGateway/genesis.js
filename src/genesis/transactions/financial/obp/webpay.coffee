FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Webpay extends FinancialBase

  getTransactionType: ->
    TransactionTypes.WEBPAY

module.exports = Webpay
