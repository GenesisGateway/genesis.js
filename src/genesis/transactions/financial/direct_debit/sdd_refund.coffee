SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class SddRefund extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_REFUND

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'usage',
          'reference_id'
        ]
      )

module.exports = SddRefund
