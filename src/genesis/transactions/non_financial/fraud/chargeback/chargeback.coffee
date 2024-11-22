
Base = require '../../../base'

class Chargeback extends Base

  constructor: (params, configuration) ->
    super params, configuration

  getTransactionType: ->
    'chargeback_request'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'chargebacks'

  getTrxData: ->
    'chargeback_request':
      @params

module.exports = Chargeback
