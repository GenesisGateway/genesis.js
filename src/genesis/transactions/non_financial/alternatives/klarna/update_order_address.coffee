
Request          = require '../../../../request'
TransactionTypes = require '../../../../helpers/transaction/types'

# Klarna Services - Update Order Address.
#
# Standalone XML service request operating on an existing Invoice transaction by
# transaction_id. It is a POST to the direct klarna/... gate endpoint (no
# payment_transaction envelope, no terminal token). The billing_address and
# shipping_address objects pass through as their own XML wrappers; empty optional
# address fields are removed by the base Request sanitization.
class KlarnaUpdateOrderAddress extends Request

  KLARNA_UPDATE_ORDER_ADDRESS_URL: 'klarna/update_order_address'

  getTransactionType: ->
    TransactionTypes.KLARNA_UPDATE_ORDER_ADDRESS

  getUrl: ->
    app:
      'gate'
    path:
      @KLARNA_UPDATE_ORDER_ADDRESS_URL

  getTrxData: ->
    'update_order_address_request':
      @params

module.exports = KlarnaUpdateOrderAddress
