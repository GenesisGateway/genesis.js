Request = require '../../../request'

###
  Fetch all active managed recurring items for a merchant.
###
class ManagedRecurringItems extends Request

  MANAGED_RECURRING_ITEMS_URL: 'v1/managed_recurring/items'

  constructor: (params, configuration) ->
    super(params, configuration, 'get')

  getTransactionType: ->
    'managed_recurring_items'

  getUrl: ->
    app:  'gate'
    path: @MANAGED_RECURRING_ITEMS_URL

module.exports = ManagedRecurringItems
