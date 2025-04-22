Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

class Cryptogram extends Request

  CRYPTOGRAM_URL: 'v1/cryptogram'

  getTransactionType: ->
    TransactionTypes.CRYPTOGRAM

  getUrl: ->
    app:
      'gate'
    path:
      @CRYPTOGRAM_URL

  getTrxData: ->
    'cryptogram_request':
      @params

module.exports = Cryptogram
