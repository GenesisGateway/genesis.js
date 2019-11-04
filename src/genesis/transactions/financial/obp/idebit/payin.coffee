
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
StringValidator  = require '../../../../helpers/validators/string_validator'

class IDebitPayin extends FinancialBase

  getTransactionType: ->
    TransactionTypes.IDEBIT_PAYIN

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'return_url',
          'customer_account_id',
          'customer_email',
          'billing_address.country'
        ]
      )

    @fieldsValues['transaction_id'] = new StringValidator 1, 30
    @fieldsValues['billing_address.country'] = ['CA']
    @fieldsValues['currency'] = ['CAD', 'USD', 'EUR', 'GBP', 'AUD']


module.exports = IDebitPayin