
Request = require '../../../request'
config  = require 'config'

class Reconcile extends Request

  constructor: (params, configuration) ->
    super params, configuration
    @configuration = configuration

  getTransactionType: ->
    'reconcile'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'reconcile'
    token:
      @configuration.getCustomerToken()

  getTrxData: ->
    'reconcile':
      @params

module.exports = Reconcile
