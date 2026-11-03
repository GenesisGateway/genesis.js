
Request = require '../../../../request'

###
  Create a Business record
###
class KycCreateBusiness extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_create_business'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/businesses'

  getTrxData: ->
    @params

module.exports = KycCreateBusiness
