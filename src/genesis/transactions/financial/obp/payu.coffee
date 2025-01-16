FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Payu extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PAYU

module.exports = Payu
