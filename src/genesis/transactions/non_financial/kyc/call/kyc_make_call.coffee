
Request = require '../../../../request'

###
  This method is used to make a call or send an SMS to a given phone number.
  This method is used to complement the verification process.
  The system will make a call and dictate the verification code to be typed in the website.
###
class KycMakeCall extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_make_call'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/create_authentication'

  getTrxData: ->
    @params

module.exports = KycMakeCall
