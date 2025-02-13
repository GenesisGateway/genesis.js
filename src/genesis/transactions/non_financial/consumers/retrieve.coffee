Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class RetrieveConsumer extends Request

  RETRIEVE_CONSUMER_URL: 'v1/retrieve_consumer'

  getTransactionType: ->
    TransactionTypes.RETRIEVE_CONSUMER

  getUrl: ->
    app:
      'gate'
    path:
      @RETRIEVE_CONSUMER_URL

  getTrxData: ->
    'retrieve_consumer_request':
      @params

module.exports = RetrieveConsumer
