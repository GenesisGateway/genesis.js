FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class RussianMobileSale extends FinancialBase

  getTransactionType: ->
    TransactionTypes.RUSSIAN_MOBILE_SALE

module.exports = RussianMobileSale
