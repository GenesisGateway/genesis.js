
Request = require '../../../../request'

class Retrieval extends Request

  getTransactionType: ->
    'retrieval_request_request'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'retrieval_requests'

  getTrxData: ->
    'retrieval_request_request':
      @params

module.exports = Retrieval
