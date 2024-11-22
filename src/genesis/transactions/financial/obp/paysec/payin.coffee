
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
NumberValidator  = require '../../../../helpers/validators/number_validator'

class PaySecPayin extends FinancialBase

  getTransactionType: ->
    TransactionTypes.PAYSEC_PAYIN

  constructor: (params, configuration) ->
    super params, configuration

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'remote_ip',
          'return_success_url',
          'return_failure_url'
        ]
      )

    @fieldsValues['currency'] = ['CNY', 'THB', 'IDR']

    #Minimum amount for CNY and THB is 10.00, for IDR is 10000.00
    @fieldsValuesConditional =
      'currency':
        'CNY': {
          'amount': new NumberValidator 10
        }
        'THB': {
          'amount': new NumberValidator 10
        }
        'IDR': {
          'amount': new NumberValidator 10000
        }

module.exports = PaySecPayin
