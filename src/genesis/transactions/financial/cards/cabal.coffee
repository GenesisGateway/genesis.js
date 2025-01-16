TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class Cabal extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CABAL

module.exports = Cabal
