Request = require '../../../request'

class ProcessedTransactionsByPostDate extends Request

  getTransactionType: ->
    'processed_transactions_by_post_date'

  getData: () ->
    @params

  getUrl: ->
    app:
      'gate'
    path:
      'processed_transactions/by_post_date'

  getTrxData: ->
    'processed_transaction_request':
      @params

module.exports = ProcessedTransactionsByPostDate
