
Base   = require '../../base'
config = require 'config'

class ReconcileByDate extends Base

  constructor: (params) ->
    super params

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
      config.customer.token

  getTrxData: ->
    'reconcile':
      @params

module.exports = ReconcileByDate