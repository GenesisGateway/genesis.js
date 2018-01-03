
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
NumberValidator  = require '../../../../helpers/validators/number'

class PaySecPayout extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PAYSEC_PAYOUT

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'remote_ip',
          'notification_url',
          'return_success_url',
          'return_failure_url',
          'bank_account_name',
          'bank_account_number',
          'billing_address.first_name',
          'billing_address.last_name',
          'billing_address.state',
          'billing_address.country'
        ]
      )

    @requiredFieldsConditional =
      'currency':
        CNY: ['bank_branch', 'bank_name']
        IDR: ['bank_code']
        THB: ['bank_name']

    @fieldsValues['currency'] = ['CNY', 'THB', 'IDR']

    #Minimum amount for CNY is 60.00, for IDR is 50000.00 and for THB is 350.00
    @fieldsValuesConditional =
      'currency':
        'CNY': {
          'amount': new NumberValidator 60
          'bank_account_number': new RegExp '^[0-9]{19}$'
        }
        'IDR': {
          'amount': new NumberValidator 50000
        }
        'THB': {
          'amount': new NumberValidator 350
        }

module.exports = PaySecPayout