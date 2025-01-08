
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Sofort extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.SOFORT

module.exports = Sofort
