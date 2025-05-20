FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class BitpaySale extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BITPAY_SALE

module.exports = BitpaySale
