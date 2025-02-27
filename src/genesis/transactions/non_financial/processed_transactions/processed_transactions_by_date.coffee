Request = require '../../../request'

class ProcessedTransactionsByDate extends Request

  getTransactionType: ->
    'processed_transactions_by_date'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'processed_transactions/by_date'

  getTrxData: ->
    'processed_transaction_request':
      @params

module.exports = ProcessedTransactionsByDate
