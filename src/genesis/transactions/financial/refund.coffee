
FinancialBase    = require './financial_base'
TransactionTypes = require '../../helpers/transaction/types'
_                = require 'underscore'

class Refund extends FinancialBase

  getTransactionType: ->
    TransactionTypes.REFUND

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'reference_id',
        ]
      )

module.exports = Refund
