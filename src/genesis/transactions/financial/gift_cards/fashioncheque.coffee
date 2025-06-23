
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Fashioncheque extends FinancialBase

  getTransactionType: ->
    TransactionTypes.FASHIONCHEQUE

module.exports = Fashioncheque
