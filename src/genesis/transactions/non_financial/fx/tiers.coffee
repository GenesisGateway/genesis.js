Request          = require '../../../request'

###
  Returns all Tiers that are related to your account
###
class Tiers extends Request

  FX_TIERS: 'v1/fx/tiers'

  # Tiers constructor with HTTP GET method
  constructor: (params, configuration) ->
    super(params, configuration, 'get')

  # Tiers type that indicates the used JSON schema
  getTransactionType: ->
    'fx_tiers'

  # Tiers endpoint
  getUrl: ->
    app:
      'gate'
    path:
      @FX_TIERS

module.exports = Tiers
