
Request             = require '../../request'
TransactionTypes    = require '../../helpers/transaction/types'
_                   = require 'underscore'
config              = require 'config'
CreditCardValidator = require '../../helpers/validators/credit_card_validator'
Promise             = require 'bluebird'

class Avs extends Request

  getTransactionType: ->
    TransactionTypes.AVS

  constructor: (params, configuration) ->
    super params, configuration
    @configuration = configuration

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
      @configuration.getCustomerToken()

  getTrxData: ->
    'payment_transaction':
      _.extend(
        @params,
        {
          'transaction_type':
            @getTransactionType()
        }
      )

  send: () ->
    return Promise.reject 'The selected transaction type is deprecated!'

module.exports = Avs
