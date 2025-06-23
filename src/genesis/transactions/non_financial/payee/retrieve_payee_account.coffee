Request = require '../../../request'
_       = require 'underscore'

###
  Retrieve the details of a specific Account record based on its unique ID
  that belongs to specific Payee
###
class RetrievePayeeAccount extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'get')

    @populateIdentifiers()

  getTransactionType: ->
    'retrieve_payee_account'

  # Request endpoint
  getUrl: ->
    app:
      'smart_router'
    path:
      "payee/#{@payee_unique_id}/account/#{@account_unique_id}"

  # Populate parameters used in the endpoint
  populateIdentifiers: ->
    @payee_unique_id   = ''
    @account_unique_id = ''

    if @params instanceof Object && @params.hasOwnProperty('payee_unique_id')
      @payee_unique_id   = @params.payee_unique_id

    if @params instanceof Object && @params.hasOwnProperty('account_unique_id')
      @account_unique_id = @params.account_unique_id

module.exports = RetrievePayeeAccount
