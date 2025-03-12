Request = require '../../../../request'

###
  Verification status check request can be performed by reference_id.
  A status check may be needed if async notification has not arrived yet or
  when kyc notifications are not used in general.
###
class KycVerificationStatus extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_verification_status'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/verifications/status'

  getTrxData: ->
    @params

module.exports = KycVerificationStatus
