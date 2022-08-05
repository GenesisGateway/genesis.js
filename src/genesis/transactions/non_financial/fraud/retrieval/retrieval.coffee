
Base = require '../../../base'

class Retrieval extends Base

  constructor: (params) ->
    super params

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