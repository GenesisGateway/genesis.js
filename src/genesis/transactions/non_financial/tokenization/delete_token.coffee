Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class DeleteToken extends Request

  DELETE_TOKEN_URL: 'v1/delete_token'

  getTransactionType: ->
    TransactionTypes.DELETE_TOKEN

  getUrl: ->
    app:
      'gate'
    path:
      @DELETE_TOKEN_URL

  getTrxData: ->
    'delete_token_request':
      @params

module.exports = DeleteToken
