Request = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'

###
  Update Account related to a specific Payee.
###
class UpdatePayeeAccount extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'patch')

    @populateIdentifiers()

  getTransactionType: ->
    TransactionTypes.UPDATE_PAYEE_ACCOUNT

  # Request endpoint
  getUrl: ->
    app:
      'smart_router'
    path:
      "payee/#{@payee_unique_id}/account/#{@account_unique_id}"

  getTrxData: ->
    delete @params.payee_unique_id
    delete @params.account_unique_id

    @params

# Populate parameters used in the endpoint
  populateIdentifiers: ->
    @payee_unique_id   = ''
    @account_unique_id = ''

    if @params instanceof Object && @params.hasOwnProperty('payee_unique_id')
      @payee_unique_id   = @params.payee_unique_id

    if @params instanceof Object && @params.hasOwnProperty('account_unique_id')
      @account_unique_id = @params.account_unique_id

module.exports = UpdatePayeeAccount
