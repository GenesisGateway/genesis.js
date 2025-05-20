FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class BitpayRefund extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BITPAY_REFUND

module.exports = BitpayRefund
