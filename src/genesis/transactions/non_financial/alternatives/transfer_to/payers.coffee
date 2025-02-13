
Request          = require '../../../../request'
TransactionTypes = require '../../../../helpers/transaction/types'

class Payers extends Request

  TRANSFER_TO_PAYERS_URL: 'transfer_to_payers/payers'

  constructor: (params, configuration) ->
    super(params, configuration, 'get')

  getTransactionType: ->
    TransactionTypes.TRANSFER_TO_PAYERS

  getUrl: ->
    app:
      'gate'
    path:
      @TRANSFER_TO_PAYERS_URL

module.exports = Payers
