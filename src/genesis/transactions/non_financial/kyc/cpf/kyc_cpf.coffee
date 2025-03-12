Request = require '../../../../request'
util    = require 'util'

###
  Check the status of a specific Brazilian personal's CPF number.
  The CPF number is provided in the request URL as a parameter.
###
class KycCpf extends Request

  CPF = '/api/v1/cpf/%s'

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

    @populateIdentifier()

  getTransactionType: ->
    'kyc_cpf'

  getData: () ->
    @params

  getUrl: ->
    app:
      'kyc'
    path:
      util.format CPF, @documentId

  getTrxData: ->
    @params

 # Populate Document ID used in the endpoint
  populateIdentifier: ->
    @documentId = ''

    @documentId =
      @params.document_id if @params instanceof Object && @params.hasOwnProperty('document_id')

module.exports = KycCpf
