
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class PPRO extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.PPRO

module.exports = PPRO
