
Request = require '../../../../request'

###
  Review all aspects of the customer’s information, as it is received in the registration
  process, against local and external databases to increase accuracy and produce a risk score
  for that customer.
###
class KycCreateConsumer extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_create_consumer'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/create_consumer'

  getTrxData: ->
    @params

module.exports = KycCreateConsumer
