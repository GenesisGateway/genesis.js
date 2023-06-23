SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'

class SddRecurringSale extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_RECURRING_SALE

module.exports = SddRecurringSale
