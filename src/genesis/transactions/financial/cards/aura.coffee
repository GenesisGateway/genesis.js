TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class Aura extends FinancialBase

  getTransactionType: ->
    TransactionTypes.AURA

module.exports = Aura
