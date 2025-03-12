
Request = require '../../../../request'

###
  Update the customer registration to be able to pass on the latest status required so
  we can continue improving the data models and provide the best scores and recommendations
  possible.
###
class KycUpdateConsumer extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_update_consumer'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/update_consumer'

  getTrxData: ->
    @params

module.exports = KycUpdateConsumer
