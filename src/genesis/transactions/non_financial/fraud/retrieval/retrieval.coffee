
Base = require '../../../base'

class Retrieval extends Base

  constructor: (params, configuration) ->
    super params, configuration

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
