
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class AfricanMobileSale extends FinancialBase

  getTransactionType: ->
    TransactionTypes.AFRICAN_MOBILE_SALE

module.exports = AfricanMobileSale
