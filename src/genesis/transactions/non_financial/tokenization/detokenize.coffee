Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class Detokenize extends Request

  DETOKENIZE_URL: 'v1/detokenize'

  getTransactionType: ->
    TransactionTypes.DETOKENIZE

  getUrl: ->
    app:
      'gate'
    path:
      @DETOKENIZE_URL

  getTrxData: ->
    'detokenize_request':
      @params

module.exports = Detokenize
