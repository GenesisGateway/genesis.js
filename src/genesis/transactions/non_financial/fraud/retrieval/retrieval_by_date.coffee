
Request = require '../../../../request'

class FraudReportByDate extends Request

  getTransactionType: ->
    'retrieval_by_date_request_request'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'retrieval_requests/by_date'

  getTrxData: ->
    'retrieval_request_request':
      @params

module.exports = FraudReportByDate
