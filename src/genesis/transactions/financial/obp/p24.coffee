
AlternativeBase  = require '../alternative/alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class P24 extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.P24

module.exports = P24
