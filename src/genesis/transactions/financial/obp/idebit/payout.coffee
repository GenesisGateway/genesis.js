
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
StringValidator  = require '../../../../helpers/validators/string_validator'

class IDebitPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.IDEBIT_PAYOUT

  constructor: (params, configuration) ->
    super params, configuration

module.exports = IDebitPayout
