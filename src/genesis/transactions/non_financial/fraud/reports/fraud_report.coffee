
Base = require '../../../base'

class FraudReport extends Base

  constructor: (params, configuration) ->
    super params, configuration

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
