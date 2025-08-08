FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class RapiPago extends FinancialBase

  getTransactionType: ->
    TransactionTypes.RAPI_PAGO

module.exports = RapiPago
