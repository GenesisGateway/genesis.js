
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
StringValidator  = require '../../../../helpers/validators/string_validator'

class IDebitPayin extends FinancialBase

  getTransactionType: ->
    TransactionTypes.IDEBIT_PAYIN

  constructor: (params, configuration) ->
    super params, configuration


module.exports = IDebitPayin
