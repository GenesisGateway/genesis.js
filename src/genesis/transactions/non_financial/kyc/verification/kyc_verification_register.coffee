Request = require '../../../../request'

###
  Verification register request can be performed by reference_id.
  A reference id registration allows you to store the reference id in Genesis
  and receive notifications in Genesis for it.
###
class KycVerificationRegister extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_verification_register'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/verifications/register'

  getTrxData: ->
    @params

module.exports = KycVerificationRegister
