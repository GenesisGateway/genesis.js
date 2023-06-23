SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'

class SddRefund extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_REFUND

module.exports = SddRefund
