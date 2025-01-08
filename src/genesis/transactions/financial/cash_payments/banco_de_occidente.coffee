FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class BancoDeOccidente extends FinancialBase

  getTransactionType: ->
    TransactionTypes.BANCO_DE_OCCIDENTE

module.exports = BancoDeOccidente
