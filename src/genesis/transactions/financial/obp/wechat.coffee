
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'
NumberValidator  = require '../../../helpers/validators/number_validator'

class Wechat extends FinancialBase

  getTransactionType: ->
    TransactionTypes.WECHAT

  constructor: (params, configuration) ->
    super params, configuration

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'usage',
          'return_success_url',
          'return_success_url',
          'billing_address.country'
        ]
      )

    @fieldsValues['amount'] = new NumberValidator 0, 999999

module.exports = Wechat
