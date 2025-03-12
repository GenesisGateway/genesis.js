Request = require '../../../../request'

###
  Utilize this method to update a particular transaction status so we can continue
  improving the data models and provide the best scores and recommendations.
###
class KycUpdateTransaction extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_update_transaction'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/update_transaction'

  getTrxData: ->
    @params

module.exports = KycUpdateTransaction
