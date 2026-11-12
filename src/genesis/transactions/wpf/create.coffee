
Request          = require '../../request'
util             = require 'util'
_                = require 'underscore'
TransactionTypes = require '../../helpers/transaction/types'
i18n             = require '../../helpers/i18n'

class Create extends Request

  constructor: (params, configuration) ->
    super params, configuration

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

  getData: () ->
    _.extend(
      {},
      @params,
      transaction_type: @getTransactionType()
    )

  getUrl: ->
    app:
      'wpf'
    path:
      util.format '%s/wpf', @locale

  getOutboundParams: ->
    outboundParams = _.clone @params

    if @params.transaction_types
      outboundParams.transaction_types = _.map @params.transaction_types, (value) ->
        if _.isObject(value)
          clonedType = _.clone value
          for key of clonedType
            if _.isObject(clonedType[key])
              clonedType[key] = _.clone clonedType[key]
              if clonedType[key].managed_recurring
                clonedType[key].managed_recurring = _.clone clonedType[key].managed_recurring
          clonedType
        else
          value

    if @params.reminders
      outboundParams.reminders = _.clone @params.reminders

    outboundParams

  getTrxData: ->
    currency       = @currency
    outboundParams = @getOutboundParams()
    params         = outboundParams

    # Locale is not inside the request data
    delete outboundParams.locale

    handleReminders

    'wpf_payment':
      _.extend(
        {},
        outboundParams,
        {
          'amount':
            @currency.convertToMinorUnits outboundParams.amount, outboundParams.currency
          'transaction_types':
            transaction_type:
              _.map outboundParams.transaction_types,(value) ->
                if (value instanceof Object)
                  for key of value
                    handleManagedRecurring(key, value[key], currency, params)

                    return Object.assign({"@": name: key.toString()}, value[key])

                return {"@": name: value.toString()}
        }
      )

  handleReminders = ->
    if @params.reminders && @params.pay_later != null
      if @params.pay_later == true
        reminders = @params.reminders
        @params.reminders = {}
        @params.reminders.reminder = reminders

      if @params.pay_later == false
        delete @params.reminder_language
        delete @params.reminders


  handleManagedRecurring = (key, value, currency, params) ->
    trxTypesWithManagedRecurring = [
      'authorize',
      'authorize3d',
      'sale',
      'sale3d',
      'init_recurring_sale',
      'init_recurring_sale3d'
    ]

    if (trxTypesWithManagedRecurring.indexOf(key) >= 0)
      if value.managed_recurring
        if value.managed_recurring.hasOwnProperty('amount')
          value.managed_recurring.amount = currency.convertToMinorUnits(
            value.managed_recurring.amount, params.currency
          )
        if value.managed_recurring.hasOwnProperty('max_amount')
          value.managed_recurring.max_amount = currency.convertToMinorUnits(
            value.managed_recurring.max_amount, params.currency
          )

module.exports = Create
