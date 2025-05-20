FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class BitpayPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BITPAY_PAYOUT

module.exports = BitpayPayout
