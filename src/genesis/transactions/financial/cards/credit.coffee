
FinancialBase    = require '../financial_base'
_                = require 'underscore'
TransactionTypes = require '../../../helpers/transaction/types'

class Credit extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CREDIT

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'reference_id'
        ]
      )

module.exports = Credit