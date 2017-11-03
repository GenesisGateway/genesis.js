
Base = require '../../../base'

class ChargebackByDate extends Base

  constructor: (params) ->
    super params

    @requiredFields = [
      'start_date'
    ]

  getUrl: ->
    app:
      'gate'
    path:
      'chargebacks/by_date'

  getTrxData: ->
    'chargeback_request':
      @params

module.exports = ChargebackByDate