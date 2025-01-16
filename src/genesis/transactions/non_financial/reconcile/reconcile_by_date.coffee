
Request = require '../../../request'
config  = require 'config'

class ReconcileByDate extends Request

  constructor: (params, configuration) ->
    super params, configuration
    @configuration = configuration

  getTransactionType: ->
    'reconcile_by_date'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'reconcile/by_date'
    token:
      @configuration.getCustomerToken()

  getTrxData: ->
    'reconcile':
      @params

module.exports = ReconcileByDate
