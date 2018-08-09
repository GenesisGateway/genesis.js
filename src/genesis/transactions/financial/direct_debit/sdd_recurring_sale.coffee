SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'

_                = require 'underscore'

class SddRecurringSale extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_RECURRING_SALE

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

module.exports = SddRecurringSale
