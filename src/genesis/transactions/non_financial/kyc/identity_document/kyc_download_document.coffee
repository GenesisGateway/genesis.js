Request = require '../../../../request'

###
  Uploaded documents will be stored by legal provisions and they can be requested for review.
  Just post a JSON body with the identity document id of the given document and
  a response with the filename and the base64 encoded content of that file would be returned.
###
class KycDownloadDocument extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

  getTransactionType: ->
    'kyc_download_document'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      'api/v1/download_document'

  getTrxData: ->
    @params

module.exports = KycDownloadDocument
