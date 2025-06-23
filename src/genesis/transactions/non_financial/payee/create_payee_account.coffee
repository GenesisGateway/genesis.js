Request = require '../../../request'
_       = require 'underscore'

###
  Create an Account related to a specific Payee
###
class CreatePayeeAccount extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'json')

    @populateIdentifier()

  getTransactionType: ->
    'create_payee_account'

  # Request endpoint
  getUrl: ->
    app:
      'smart_router'
    path:
      "payee/#{@payee_unique_id}/account"

  getTrxData: ->
    delete @params.payee_unique_id

    @params

  # Populate Payee ID used in the endpoint
  populateIdentifier: ->
    @payee_unique_id = ''

    if @params instanceof Object && @params.hasOwnProperty('payee_unique_id')
      @payee_unique_id = @params.payee_unique_id

module.exports = CreatePayeeAccount
