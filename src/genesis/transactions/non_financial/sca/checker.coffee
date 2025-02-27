_       = require 'underscore'
Request = require '../../../request'

###
  Genesis SCA(Strong Customer Authentication).
  Services provides the ability to check if a transaction is in the scope of SCA.
###
class ScaChecker extends Request
  CHECKER_URL = 'v1/sca/checker'

  # Endpoint JSON POST constructor
  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  # Transaction type defines used JSON Schema
  getTransactionType: ->
    'sca_checker'

  # Checker endpoint configuration
  getUrl: ->
    app:
      'gate'
    path:
      CHECKER_URL
    token:
      @configuration.getCustomerToken()

  # API request payload
  getTrxData: ->
    params = {}
    params = _.clone @params if _.isObject(@params)

    params.transaction_amount = Number(@parseAmount(params)) unless _.isEmpty(params)

    params

  # Convert amount to minor currency unit
  parseAmount: (params) ->
    if params.transaction_amount and params.transaction_currency
      return @currency.convertToMinorUnits params.transaction_amount, params.transaction_currency

    params.transaction_amount

module.exports = ScaChecker
