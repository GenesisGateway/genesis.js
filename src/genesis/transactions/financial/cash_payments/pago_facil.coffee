
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class PagoFacil extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PAGO_FACIL

module.exports = PagoFacil
