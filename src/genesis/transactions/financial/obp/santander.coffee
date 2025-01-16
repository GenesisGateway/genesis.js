FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Santander extends FinancialBase

  getTransactionType: ->
    TransactionTypes.SANTANDER

module.exports = Santander
