
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class ApplePay extends FinancialBase

  getTransactionType: ->
    TransactionTypes.APPLE_PAY

  getTrxData: ->
    trxData = super()

    trxData.payment_transaction.payment_token = JSON.stringify(
      trxData.payment_transaction.payment_token
    )

    trxData

module.exports = ApplePay
