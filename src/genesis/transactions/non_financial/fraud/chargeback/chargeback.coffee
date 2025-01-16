
Request = require '../../../../request'

class Chargeback extends Request

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
