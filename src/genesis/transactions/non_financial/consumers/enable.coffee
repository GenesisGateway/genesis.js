Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class EnableConsumer extends Request

  ENABLE_CONSUMER_URL: 'v1/enable_consumer'

  getTransactionType: ->
    TransactionTypes.ENABLE_CONSUMER

  getUrl: ->
    app:
      'gate'
    path:
      @ENABLE_CONSUMER_URL

  getTrxData: ->
    'enable_consumer_request':
      @params

module.exports = EnableConsumer
