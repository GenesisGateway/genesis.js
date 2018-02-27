
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'
NumberValidator  = require '../../../helpers/validators/number'

class Alipay extends FinancialBase

  getTransactionType: ->
    TransactionTypes.ALIPAY

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'usage',
          'remote_ip',
          'return_success_url',
          'return_failure_url'
        ]
      )

    @fieldsValues['currency'] = ['CNY']
    @fieldsValues['amount'] = new NumberValidator (10)

module.exports = Alipay
