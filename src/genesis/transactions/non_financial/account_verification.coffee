
Base                = require '../base'
TransactionTypes    = require '../../helpers/transaction/types'
_                   = require 'underscore'
config              = require 'config'
CreditCardValidator = require '../../helpers/validators/credit_card_validator'

class AccountVerification extends Base

  getTransactionType: ->
    TransactionTypes.ACCOUNT_VERIFICATION

  constructor: (params) ->
    super params

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
