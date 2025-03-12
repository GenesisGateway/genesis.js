Request = require '../../../request'
util    = require 'util'

###
  This call is used to return all rates for Tier.
###
class Rates extends Request

  FX_RATES = 'v1/fx/tiers/%s/rates'

  # FX Rates constructor with GET HTTP Request
  constructor: (params, configuration) ->
    super(params, configuration, 'get')

    @populateIdentifier()

  # FX Rates transaction type that defines the JSON Schema
  getTransactionType: ->
    'fx_rates'

  # Rates endpoint
  getUrl: ->
    app:
      'gate'
    path:
      util.format FX_RATES, @tierId

  # Populate Tier ID used in the endpoint
  populateIdentifier: ->
    @tierId = ''

    @tierId = @params.tier_id if @params instanceof Object && @params.hasOwnProperty('tier_id')

module.exports = Rates
