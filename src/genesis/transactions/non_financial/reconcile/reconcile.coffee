
Base   = require '../../base'
config = require 'config'

class Reconcile extends Base

  constructor: (params) ->
    super params

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
      config.customer.token

  getTrxData: ->
    'reconcile':
      @params

module.exports = Reconcile