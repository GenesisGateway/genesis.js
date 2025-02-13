Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class Tokenize extends Request

  TOKENIZE_URL: 'v1/tokenize'

  getTransactionType: ->
    TransactionTypes.TOKENIZE

  getUrl: ->
    app:
      'gate'
    path:
      @TOKENIZE_URL

  getTrxData: ->
    'tokenize_request':
      @params

module.exports = Tokenize
