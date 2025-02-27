Request = require '../../../../request'

###
  Implement this to scrub a new transaction. We will take the information specific to that transaction and
  run various verification checks available, returning the recommendation, score, and third-party verification
  scrubbing results.
###
class KycCreateTransaction extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_create_transaction'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/create_transaction'

  getTrxData: ->
    @params

module.exports = KycCreateTransaction
