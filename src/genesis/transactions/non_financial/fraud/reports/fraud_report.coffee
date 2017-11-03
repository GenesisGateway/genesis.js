
Base = require '../../../base'

class FraudReport extends Base

  constructor: (params) ->
    super params

    @requiredFieldsOr = [
      'arn',
      'original_transaction_unique_id'
    ]

  getUrl: ->
    app:
      'gate'
    path:
      'fraud_reports'

  getTrxData: ->
    'fraud_report_request':
      @params

module.exports = FraudReport