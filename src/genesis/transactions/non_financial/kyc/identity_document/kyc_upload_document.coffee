Request = require '../../../../request'

###
  Used to verify documents provided by the customer.
###
class KycUploadDocument extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_upload_document'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/upload_document'

  getTrxData: ->
    @params

module.exports = KycUploadDocument
