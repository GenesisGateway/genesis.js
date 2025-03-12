Request = require '../../../request'
util    = require 'util'

###
  Retrieves details about a specific installment based on its ID.
###
class ShowDetails extends Request

  # Show Details Installments uses JSON builder
  constructor: (params, configuration) ->
    super params, configuration, 'get'

    @populateIdentifiers()

  # Show Details Installments API endpoint
  getUrl: ->
    app:
      'gate'
    path:
      util.format 'v1/installments/%s', @installmentId

  # Show Details Installments JSON schema
  getTransactionType: ->
    'installments_show_details'

  # Populate identifier used in the endpoint
  populateIdentifiers: ->
    @installmentId = ''

    if @params instanceof Object && @params.hasOwnProperty('installment_id')
      @installmentId = @params.installment_id

module.exports = ShowDetails
