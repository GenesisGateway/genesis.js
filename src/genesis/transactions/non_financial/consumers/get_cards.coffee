
Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class GetCards extends Request

  GET_CONSUMER_CARDS_URL: 'v1/get_consumer_cards'

  getTransactionType: ->
    TransactionTypes.GET_CONSUMER_CARDS

  getUrl: ->
    app:
      'gate'
    path:
      @GET_CONSUMER_CARDS_URL

  getTrxData: ->
    'get_consumer_cards_request':
      @params

module.exports = GetCards
