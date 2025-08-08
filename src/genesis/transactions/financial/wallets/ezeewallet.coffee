
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class EzeeWallet extends FinancialBase

  getTransactionType: ->
    TransactionTypes.EZEEWALLET

module.exports = EzeeWallet
