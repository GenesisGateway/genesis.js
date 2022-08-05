
Base             = require '../base'
util             = require 'util'
_                = require 'underscore'
AmountValidator  = require '../../helpers/validators/amount_validator'
TransactionTypes = require '../../helpers/transaction/types'
i18n             = require '../../helpers/i18n'

class Create extends Base

  constructor: (params) ->
    super params

    # Set Locale
    @setLocale()

    @transactionTypes = new TransactionTypes
    @i18n             = new i18n

  getTransactionType: ->
    'wpf_create'

  setLocale: ->
    if @params && @params.locale then @locale = @params.locale.slice 0, 2 else @locale = 'en'
    if @params then @params.locale = @locale

  setData: (@params) ->
    @setLocale()
    @

  getUrl: ->
    app:
      'wpf'
    path:
      util.format '%s/wpf', @locale

  getTrxData: ->
    # Locale is not inside the request data
    if @params then delete @params.locale

    'wpf_payment':
      _.extend(
        @params,
        {
          'amount':
            @currency.convertToMinorUnits @params.amount, @params.currency
          'transaction_types':
            transaction_type:
              _.map @params.transaction_types, (value) ->
                if (value instanceof Object)
                  for key of value
                    return Object.assign({"@": name: key.toString()}, value[key])

                return {"@": name: value.toString()}

        }
      )


module.exports = Create
