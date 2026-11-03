Request = require '../../../request'
util    = require 'util'

###
  Cancel a managed recurring item by its unique id.
  Gateway returns HTTP 204 No Content on success.
###
class ManagedRecurringCancel extends Request

  MANAGED_RECURRING_CANCEL_URL = 'v1/managed_recurring/items/%s'

  constructor: (params, configuration) ->
    super(params, configuration, 'delete')

    @populateIdentifier()

  getTransactionType: ->
    'managed_recurring_cancel'

  getUrl: ->
    app:  'gate'
    path: util.format MANAGED_RECURRING_CANCEL_URL, @uniqueId

  populateIdentifier: ->
    @uniqueId = ''

    if @params instanceof Object && @params.hasOwnProperty('unique_id')
      @uniqueId = @params.unique_id

module.exports = ManagedRecurringCancel
