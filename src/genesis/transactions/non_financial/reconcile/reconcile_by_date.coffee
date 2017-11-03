
Base   = require '../../base'
config = require 'config'

class ReconcileByDate extends Base

  constructor: (params) ->
    super params

    @requiredFields = [
      'start_date'
    ]

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