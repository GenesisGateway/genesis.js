
Base            = require '../base'
_               = require 'underscore'
config          = require 'config'
AmountValidator = require '../../helpers/validators/amount'
StringValidator = require '../../helpers/validators/string'

class FinancialBase extends  Base

  constructor: (params) ->
    super params

    @requiredFields =
      [
        'transaction_id',
        'amount',
        'currency'
      ]

    @fieldsValues =
      'transaction_id':
        new StringValidator undefined, 255
      'currency':
        @currency.getCurrencies()
      'amount':
        new AmountValidator

  getUrl: ->
    app:
      'gate'
    path:
      'process'
    token:
      config.customer.token

  getTrxData: ->

    # convert amount to minor units
    if @params.amount and @params.currency
      @params.amount = @currency.convertToMinorUnits @params.amount, @params.currency

    'payment_transaction':
      _.extend(
        @params,
        {
          'transaction_type':
            this.getTransactionType()
        }
      )

module.exports = FinancialBase
