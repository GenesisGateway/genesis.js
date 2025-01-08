
AlternativeBase  = require '../alternative_base'
TransactionTypes = require '../../../../helpers/transaction/types'

class Sale extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.TRUSTLY_SALE

module.exports = Sale
