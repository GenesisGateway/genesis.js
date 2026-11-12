
Request          = require '../../../../request'
TransactionTypes = require '../../../../helpers/transaction/types'

# Klarna Services - Release Remaining Authorization.
#
# Standalone XML service request operating on an existing Invoice transaction by
# transaction_id. It is a POST to the direct klarna/... gate endpoint (no
# payment_transaction envelope, no terminal token). The default 'xml' builder
# yields POST + Content-Type: text/xml.
class KlarnaReleaseRemainingAuthorization extends Request

  KLARNA_RELEASE_REMAINING_AUTHORIZATION_URL: 'klarna/release_remaining_authorization'

  getTransactionType: ->
    TransactionTypes.KLARNA_RELEASE_REMAINING_AUTHORIZATION

  getUrl: ->
    app:
      'gate'
    path:
      @KLARNA_RELEASE_REMAINING_AUTHORIZATION_URL

  getTrxData: ->
    'release_remaining_authorization_request':
      @params

module.exports = KlarnaReleaseRemainingAuthorization
