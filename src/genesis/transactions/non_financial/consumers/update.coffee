Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class UpdateConsumer extends Request

  UPDATE_CONSUMER_URL: 'v1/update_consumer'

  getTransactionType: ->
    TransactionTypes.UPDATE_CONSUMER

  getUrl: ->
    app:
      'gate'
    path:
      @UPDATE_CONSUMER_URL

  getTrxData: ->
    'update_consumer_request':
      @params

module.exports = UpdateConsumer
