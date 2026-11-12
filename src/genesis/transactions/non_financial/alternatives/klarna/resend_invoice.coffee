
Request          = require '../../../../request'
TransactionTypes = require '../../../../helpers/transaction/types'

# Klarna Services - Resend Invoice.
#
# Standalone XML service request operating on an existing Invoice transaction by
# transaction_id. It is a POST to the direct klarna/... gate endpoint (no
# payment_transaction envelope, no terminal token). The default 'xml' builder
# yields POST + Content-Type: text/xml.
class KlarnaResendInvoice extends Request

  KLARNA_RESEND_INVOICE_URL: 'klarna/resend_invoice'

  getTransactionType: ->
    TransactionTypes.KLARNA_RESEND_INVOICE

  getUrl: ->
    app:
      'gate'
    path:
      @KLARNA_RESEND_INVOICE_URL

  getTrxData: ->
    'resend_invoice_request':
      @params

module.exports = KlarnaResendInvoice
