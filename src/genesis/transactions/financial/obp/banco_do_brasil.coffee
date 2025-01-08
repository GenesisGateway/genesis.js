FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class BancoDoBrasil extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BANCO_DO_BRASIL

module.exports = BancoDoBrasil
