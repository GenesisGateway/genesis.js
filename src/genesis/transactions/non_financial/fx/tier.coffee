Request = require '../../../request'

###
  This call is used to return information about selected Tier for your merchant.
###
class Tier extends Request

  FX_TIER = 'v1/fx/tiers'

  # FX Tier constructor with GET HTTP Request
  constructor: (params, configuration) ->
    super(params, configuration, 'get')

    @populateIdentifier()

  # FX Tier transaction type that defines the JSON Schema
  getTransactionType: ->
    'fx_tier'

  # Tier endpoint
  getUrl: ->
    app:
      'gate'
    path:
      "#{FX_TIER}/#{@identifier}"

  # Populate Tier ID used in the endpoint
  populateIdentifier: ->
    @identifier = ''

    @identifier = @params.id if @params instanceof Object && @params.hasOwnProperty('id')

module.exports = Tier
