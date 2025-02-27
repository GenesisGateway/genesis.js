Request = require '../../../request'

class ProcessedTransactions extends Request

  getTransactionType: ->
    'processed_transactions'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'processed_transactions'

  getTrxData: ->
    'processed_transaction_request':
      @params

module.exports = ProcessedTransactions
