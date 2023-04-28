
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class ApplePay extends FinancialBase

  getTransactionType: ->
    TransactionTypes.APPLE_PAY


  getTrxData: ->
    super()
    'payment_transaction':
      _.extend(
        @params,
        {
          'payment_token':
            JSON.stringify(@params['payment_token'])
        }
      )

module.exports = ApplePay
