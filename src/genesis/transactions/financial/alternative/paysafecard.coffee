
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Paysafecard extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.PAYSAFECARD

  constructor: (params) ->
    super params

module.exports = Paysafecard
