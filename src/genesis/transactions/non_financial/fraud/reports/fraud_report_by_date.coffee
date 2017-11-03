
Base = require '../../../base'

class FraudReportByDate extends Base

  constructor: (params) ->
    super params

    @requiredFields = [
      'start_date'
    ]

  getUrl: ->
    app:
      'gate'
    path:
      'fraud_reports/by_date'

  getTrxData: ->
    'fraud_report_request':
      @params

module.exports = FraudReportByDate