Request             = require '../../../request'
_                   = require 'underscore'
{ URLSearchParams } = require 'url'

###
  Retrieve the details of all Account records that belongs to specific Payee
###
class ListPayeeAccounts extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'get')

    @populateURLparameters()

  getTransactionType: ->
    'list_payee_accounts'

  # Request endpoint
  getUrl: ->
    app:
      'smart_router'
    path:
      "payee/#{@payee_unique_id}/account#{@additional_params}"

  # Populate parameters used in the endpoint
  populateURLparameters: ->
    @payee_unique_id   = ''
    if @params instanceof Object && @params.hasOwnProperty('payee_unique_id')
      @payee_unique_id = @params.payee_unique_id

    params = _.omit @params, 'payee_unique_id'

    @additional_params = ''
    @additional_params = "/?#{new URLSearchParams(params)}" if not _.isEmpty(params)

module.exports = ListPayeeAccounts
