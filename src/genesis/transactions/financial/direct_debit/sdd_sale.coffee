SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'

class SddSale extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_SALE

module.exports = SddSale
