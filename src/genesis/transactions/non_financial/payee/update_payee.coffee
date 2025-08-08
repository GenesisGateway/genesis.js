Request          = require '../../../request'
TransactionTypes = require '../../../helpers/transaction/types'


###
  Update an Account related to a specific Payee
###
class UpdatePayee extends Request

  constructor: (params, configuration) ->
    super(params, configuration, 'patch')

    @populateIdentifier()

  getTransactionType: ->
    TransactionTypes.UPDATE_PAYEE

  # Request endpoint
  getUrl: ->
    app:
      'smart_router'
    path:
      "payee/#{@payee_unique_id}"

  getTrxData: ->
    delete @params.payee_unique_id

    @params

  # Populate Payee ID used in the endpoint
  populateIdentifier: ->
    @payee_unique_id = ''

    if @params instanceof Object && @params.hasOwnProperty('payee_unique_id')
      @payee_unique_id = @params.payee_unique_id

module.exports = UpdatePayee
