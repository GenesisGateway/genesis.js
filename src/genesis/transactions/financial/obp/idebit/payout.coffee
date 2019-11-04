
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
StringValidator  = require '../../../../helpers/validators/string_validator'

class IDebitPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.IDEBIT_PAYOUT

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'reference_id'
        ]
      )

    @fieldsValues['transaction_id'] = new StringValidator 1, 30

module.exports = IDebitPayout