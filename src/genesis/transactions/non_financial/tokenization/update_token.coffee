Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class UpdateToken extends Request

  UPDATE_TOKEN_URL: 'v1/update_token'

  getTransactionType: ->
    TransactionTypes.UPDATE_TOKEN

  getUrl: ->
    app:
      'gate'
    path:
      @UPDATE_TOKEN_URL

  getTrxData: ->
    'update_token_request':
      @params

module.exports = UpdateToken
