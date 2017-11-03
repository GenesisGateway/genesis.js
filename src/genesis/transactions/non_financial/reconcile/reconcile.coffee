
Base   = require '../../base'
config = require 'config'

class Reconcile extends Base

  constructor: (params) ->
    super params

    @requiredFieldsOr = [
      'transaction_id',
      'arn',
      'unique_id'
    ]

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