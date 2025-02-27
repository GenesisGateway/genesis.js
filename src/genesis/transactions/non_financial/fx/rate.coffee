Request = require '../../../request'
util    = require 'util'

###
  This call is used to return information about selected Rate for merchant.
###
class Rate extends Request

  FX_RATE = 'v1/fx/tiers/%s/rates/%s'

  # FX Rate constructor with GET HTTP Request
  constructor: (params, configuration) ->
    super(params, configuration, 'get')

    @populateIdentifiers()

  # FX Rate transaction type that defines the JSON Schema
  getTransactionType: ->
    'fx_rate'

  # Rate endpoint
  getUrl: ->
    app:
     'gate'
    path:
      util.format FX_RATE, @tierId, @identifier

  # Populate identifiers used in the endpoint
  populateIdentifiers: ->
    @identifier = ''
    @tierId     = ''

    @identifier = @params.id if @params instanceof Object && @params.hasOwnProperty('id')
    @tierId     = @params.tier_id if @params instanceof Object && @params.hasOwnProperty('tier_id')

module.exports = Rate
