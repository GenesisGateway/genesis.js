
Base = require '../../../base'

class Retrieval extends Base

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
      'retrieval_requests'

  getTrxData: ->
    'retrieval_request_request':
      @params

module.exports = Retrieval