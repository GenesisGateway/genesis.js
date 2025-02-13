Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class ValidateToken extends Request

  VALIDATE_TOKEN_URL: 'v1/validate_token'

  getTransactionType: ->
    TransactionTypes.VALIDATE_TOKEN

  getUrl: ->
    app:
      'gate'
    path:
      @VALIDATE_TOKEN_URL

  getTrxData: ->
    'validate_token_request':
      @params

module.exports = ValidateToken
