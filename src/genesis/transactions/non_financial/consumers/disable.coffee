Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class DisableConsumer extends Request

  DISABLE_CONSUMER_URL: 'v1/disable_consumer'

  getTransactionType: ->
    TransactionTypes.DISABLE_CONSUMER

  getUrl: ->
    app:
      'gate'
    path:
      @DISABLE_CONSUMER_URL

  getTrxData: ->
    'disable_consumer_request':
      @params

module.exports = DisableConsumer
