
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
      'retrieval_requests/by_date'

  getTrxData: ->
    'retrieval_request_request':
      @params

module.exports = FraudReportByDate