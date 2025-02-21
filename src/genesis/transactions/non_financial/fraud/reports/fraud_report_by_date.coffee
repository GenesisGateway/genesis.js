
Request = require '../../../../request'

class FraudReportByDate extends Request

  getTransactionType: ->
    'fraud_report_by_date_request'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'fraud_reports/by_date'

  getTrxData: ->
    'fraud_report_request':
      @params

module.exports = FraudReportByDate
