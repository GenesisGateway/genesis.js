
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class GooglePay extends FinancialBase

  getTransactionType: ->
    TransactionTypes.GOOGLE_PAY

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

module.exports = GooglePay
