
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
StringValidator  = require '../../../../helpers/validators/string_validator'

class InstaDebitPayin extends FinancialBase

  getTransactionType: ->
    TransactionTypes.INSTA_DEBIT_PAYIN

  constructor: (params, configuration) ->
    super params, configuration

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'return_url',
          'customer_account_id',
          'billing_address.country'
        ]
      )

    @fieldsValues['transaction_id'] = new StringValidator 1, 30
    @fieldsValues['billing_address.country'] = ['CA']


module.exports = InstaDebitPayin
