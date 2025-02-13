
Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class CreateConsumer extends Request

  CREATE_CONSUMER_URL: 'v1/create_consumer'

  getTransactionType: ->
    TransactionTypes.CREATE_CONSUMER

  getUrl: ->
    app:
      'gate'
    path:
      @CREATE_CONSUMER_URL

  getTrxData: ->
    'create_consumer_request':
      @params

module.exports = CreateConsumer
