
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
    currency                     = @currency
    params                       = @params
    trxTypesWithManagedRecurring = [
      'authorize',
      'authorize3d',
      'sale',
      'sale3d',
      'init_recurring_sale',
      'init_recurring_sale3d'
    ]

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
              _.map @params.transaction_types,(value) ->
                if (value instanceof Object)
                  for key of value
                    if (trxTypesWithManagedRecurring.indexOf(key) >= 0)
                      if value[key].managed_recurring
                        if value[key].managed_recurring.amount
                          value[key].managed_recurring.amount = currency.convertToMinorUnits(
                            value[key].managed_recurring.amount, params.currency
                          )
                        if value[key].managed_recurring.max_amount
                          value[key].managed_recurring.max_amount = currency.convertToMinorUnits(
                            value[key].managed_recurring.max_amount, params.currency
                          )

                    return Object.assign({"@": name: key.toString()}, value[key])

                return {"@": name: value.toString()}
        }
      )


module.exports = Create
