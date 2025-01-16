
Request = require '../../../../request'

class FraudReport extends Request

  getTransactionType: ->
    'fraud_report_request'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'fraud_reports'

  getTrxData: ->
    'fraud_report_request':
      @params

module.exports = FraudReport
