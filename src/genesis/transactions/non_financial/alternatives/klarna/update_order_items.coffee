
Request          = require '../../../../request'
TransactionTypes = require '../../../../helpers/transaction/types'

# Klarna Services - Update Order Items.
#
# Standalone XML service request operating on an existing Invoice transaction by
# transaction_id. It is a POST to the direct klarna/... gate endpoint (no
# payment_transaction envelope, no terminal token).
#
# item_type DECISION (spec Requirement 4 open decision):
# The public param and the serialized XML element for the line-item type is
# `item_type`, matching the gateway parameter table and the SDK's item
# terminology. The gateway's XML example shows `<type>`, but the parameter table
# names the field `item_type`. We emit ONLY `<item_type>`; we do NOT emit
# `<type>` and we do NOT add a silent alias. If hard evidence surfaces that this
# endpoint only accepts `<type>`, this must be revisited rather than guessed.
#
# amount, unit_price, total_amount, total_discount_amount and total_tax_amount
# are submitted as gateway-format minor-unit integers and are passed through
# unchanged (no currency conversion, rounding, or recalculation).
class KlarnaUpdateOrderItems extends Request

  KLARNA_UPDATE_ORDER_ITEMS_URL: 'klarna/update_order_items'

  getTransactionType: ->
    TransactionTypes.KLARNA_UPDATE_ORDER_ITEMS

  getUrl: ->
    app:
      'gate'
    path:
      @KLARNA_UPDATE_ORDER_ITEMS_URL

  getTrxData: ->
    'update_order_items_request':
      @params

module.exports = KlarnaUpdateOrderItems
