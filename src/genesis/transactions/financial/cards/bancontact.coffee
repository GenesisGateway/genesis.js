TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class Bancontact extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BANCONTACT

module.exports = Bancontact
