
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

  setLocale: ->
    if @params && @params.locale then @locale = @params.locale.slice 0, 2 else @locale = 'en'
    if @params then delete @params.locale

  setData: (@params) ->
    @setLocale()
    @

  isValid: ->
    @validationErrors = []

    rules = {
      'transaction_id':
        null
      'amount':
        new AmountValidator()
      'currency':
        @currency.getCurrencies()
      'notification_url':
        null
      'return_success_url':
        null
      'return_failure_url':
        null
      'return_cancel_url':
        null
      'transaction_types':
        null
    }

    # validate locale
    if !@i18n.isValidLocale @locale
      @validationErrors.push(
        "Locale #{@locale} is not valid. Valid WPF locales are: #{@i18n.getLocales().join ', '}"
      )

    # validate transaction types
    if @params.transaction_types
      for type in @params.transaction_types

        if @transactionTypes.isValidWPFType(type)
          rules = _.extend rules, @transactionTypes.getCustomRequiredParameters(type)
        else
          @validationErrors.push(
            "Transaction type #{type} is not valid.
             Valid WPF transactions are: #{@transactionTypes.getWPFTypes().join ', '}"
          )

    @validateRequiredFields(_.keys rules)
    @validateFieldsValues(rules)

    @validationErrors.length == 0

  getUrl: ->
    app:
      'wpf'
    path:
      util.format '%s/wpf', @locale

  getTrxData: ->
    'wpf_payment':
      _.extend(
        @params,
        {
          'amount':
            @currency.convertToMinorUnits @params.amount, @params.currency
          'transaction_types':
            transaction_type:
              _.map @params.transaction_types, (value) ->
                return { "@": name: value.toString() }
        }
      )

module.exports = Create
