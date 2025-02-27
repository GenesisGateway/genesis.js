Request = require '../../../request'
util    = require 'util'
_       = require 'underscore'

###
  This call is used to return information about selected Rate by currency pair.
###
class SearchRate extends Request

  FX_SEARCH_RATE = 'v1/fx/tiers/%s/rates/search'

  # FX Search Rate constructor with JSON HTTP POST Request
  constructor: (params, configuration) ->
    super(params, configuration, 'json')

    @populateIdentifiers()

  # FX Search Rate transaction type that defines the JSON Schema
  getTransactionType: ->
    'fx_search_rate'

  # FX Search Rate endpoint
  getUrl: ->
    app:
     'gate'
    path:
      util.format FX_SEARCH_RATE, @tierId
  
  getTrxData: ->
    params = _.clone @params
    delete params.tier_id

    params

  # Populate tierId used in the endpoint
  populateIdentifiers: ->
    @tierId = ''

    @tierId = @params.tier_id if @params instanceof Object && @params.hasOwnProperty('tier_id')

module.exports = SearchRate
