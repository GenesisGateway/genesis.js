
Base                = require '../base'
TransactionTypes    = require '../../helpers/transaction/types'
_                   = require 'underscore'
config              = require 'config'
CreditCardValidator = require '../../helpers/validators/credit_card'

class AccountVerification extends Base

  getTransactionType: ->
    TransactionTypes.ACCOUNT_VERIFICATION

  constructor: (params) ->
    super params

    creditCardValidator = new CreditCardValidator

    @requiredFields =
      _.union(
        [
          'transaction_id',
          'billing_address.address1',
          'billing_address.zip_code',
          'billing_address.city'
        ],
        creditCardValidator.getCCRequiredFields()
      )

    @fieldsValues = creditCardValidator.getCCFieldValueFormatValidators()

  getUrl: ->
    app:
      'gate'
    path:
      'process'
    token:
      config.customer.token

  getTrxData: ->
    'payment_transaction':
      _.extend(
        @params,
        {
          'transaction_type':
            @getTransactionType()
        }
      )

module.exports = AccountVerification