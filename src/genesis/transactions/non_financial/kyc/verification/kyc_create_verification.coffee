Request = require '../../../../request'

###
  The verification request will provide a link that will be used to redirect
  the customer. The customer will provide the required documents and will be
  verified against them. As a result, the user will be redirected back to merchant
  based on the provided redirect URL.
###
class KycCreateVerification extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_create_verification'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/verifications'

  getTrxData: ->
    @params

module.exports = KycCreateVerification
