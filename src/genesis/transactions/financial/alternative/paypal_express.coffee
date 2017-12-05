
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class PaypalExpress extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.PAYPAL_EXPRESS

  constructor: (params) ->
    super params

    @requiredFields = _.without(
      @requiredFields,
      'remote_ip',
      'customer_email'
    )

module.exports = PaypalExpress