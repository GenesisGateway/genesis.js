
Request = require '../../../request'
config  = require 'config'

class Reconcile extends Request

  constructor: (params, configuration) ->
    super params, configuration

  getTransactionType: ->
    'reconcile'

  getData: () ->
    @params

  getUrl: ->
    if @params.use_smart_router || @configuration.getCustomerForceSmartRouter()
      return app: 'smart_router', path: 'reconcile'

    app: 'gate', path: 'reconcile', token: @configuration.getCustomerToken()

  getTrxData: ->
    'reconcile':
      @params

module.exports = Reconcile
