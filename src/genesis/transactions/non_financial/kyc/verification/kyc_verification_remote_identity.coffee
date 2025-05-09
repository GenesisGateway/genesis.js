Request = require '../../../../request'

###
  Used to verify documents provided by the customer.
###
class KycVerificationRemoteIdentity extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_verification_remote_identity'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/verifications'

  getTrxData: ->
    @params

module.exports = KycVerificationRemoteIdentity
