Request = require '../../../request'

###
  Fetch the applicable installments for a given amount, currency and card brand.
###
class Fetch extends Request

  # Fetch Installments uses JSON builder
  constructor: (params, configuration) ->
    super params, configuration, 'json'

  # Fetch Installments API endpoint
  getUrl: ->
    app:
      'gate'
    path:
      'v1/installments'

  # Fetch Installments gateway data
  getTrxData: ->
    @params

  # Fetch Installments JSON schema
  getTransactionType: ->
    'installments_fetch'

module.exports = Fetch
