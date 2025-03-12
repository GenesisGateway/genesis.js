
Request = require '../../../../request'

###
  This method is used to update the call status with the latest info
  received from the main system. It also updates the transaction
  associated with this verification call.
###
class KycUpdateCall extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_update_call'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/update_authentication'

  getTrxData: ->
    @params

module.exports = KycUpdateCall
