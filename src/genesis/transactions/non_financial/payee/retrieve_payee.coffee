Request = require '../../../request'

###
  Retrieve the details of a specific a Payee record based on its unique ID
###
class RetrievePayee extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'get')

    @populateIdentifier()

  getTransactionType: ->
    'retrieve_payee'

  # Request endpoint
  getUrl: ->
    app:
      'smart_router'
    path:
      "payee/#{@identifier}"

  # Populate Payee ID used in the endpoint
  populateIdentifier: ->
    @identifier = ''

    if @params instanceof Object && @params.hasOwnProperty('payee_unique_id')
      @identifier = @params.payee_unique_id

module.exports = RetrievePayee
