TransactionTypes = require '../../../helpers/transaction/types'
FinancialBase    = require '../financial_base'

class TarjetaShopping extends FinancialBase

  getTransactionType: ->
    TransactionTypes.TARJETA_SHOPPING

module.exports = TarjetaShopping
