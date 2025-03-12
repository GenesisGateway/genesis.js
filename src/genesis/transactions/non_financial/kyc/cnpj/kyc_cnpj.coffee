Request = require '../../../../request'
util    = require 'util'

###
  Check the status of a specific Brazilian company's CNPJ number.
  The CNPJ number is provided in the request URL as a parameter.
###
class KycCnpj extends Request

  CNPJ = '/api/v1/cnpj/%s'

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

    @populateIdentifier()

  getTransactionType: ->
    'kyc_cnpj'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      util.format CNPJ, @documentId

  getTrxData: ->
    @params

 # Populate Document ID used in the endpoint
  populateIdentifier: ->
    @documentId = ''

    @documentId =
      @params.document_id if @params instanceof Object && @params.hasOwnProperty('document_id')

module.exports = KycCnpj
