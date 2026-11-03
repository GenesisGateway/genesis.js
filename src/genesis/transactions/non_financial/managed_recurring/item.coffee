Request = require '../../../request'
util    = require 'util'

###
  Fetch a single active managed recurring item by its unique id.
###
class ManagedRecurringItem extends Request

  MANAGED_RECURRING_ITEM_URL = 'v1/managed_recurring/items/%s'

  constructor: (params, configuration) ->
    super(params, configuration, 'get')

    @populateIdentifier()

  getTransactionType: ->
    'managed_recurring_item'

  getUrl: ->
    app:  'gate'
    path: util.format MANAGED_RECURRING_ITEM_URL, @uniqueId

  populateIdentifier: ->
    @uniqueId = ''

    if @params instanceof Object && @params.hasOwnProperty('unique_id')
      @uniqueId = @params.unique_id

module.exports = ManagedRecurringItem
