
Base = require '../../../base'

class Chargeback extends Base

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
      'chargebacks'

  getTrxData: ->
    'chargeback_request':
      @params

module.exports = Chargeback