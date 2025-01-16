FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Elo extends FinancialBase

  getTransactionType: ->
    TransactionTypes.ELO

module.exports = Elo
