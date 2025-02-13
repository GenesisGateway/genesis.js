Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class GetTokenizedCard extends Request

  GET_CARD_URL: 'v1/get_card'

  getTransactionType: ->
    TransactionTypes.GET_TOKENIZED_CARD

  getUrl: ->
    app:
      'gate'
    path:
      @GET_CARD_URL

  getTrxData: ->
    'get_card_request':
      @params

module.exports = GetTokenizedCard
