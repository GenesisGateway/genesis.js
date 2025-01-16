
Request = require '../../../../request'

class ChargebackByDate extends Request

  getTransactionType: ->
    'chargeback_by_date_request'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'chargebacks/by_date'

  getTrxData: ->
    'chargeback_request':
      @params

module.exports = ChargebackByDate
