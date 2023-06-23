SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'

class SddInitRecurringSale extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_INIT_RECURRING_SALE

module.exports = SddInitRecurringSale
