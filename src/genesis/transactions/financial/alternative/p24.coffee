
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class P24 extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.P24

  constructor: (params) ->
    super params

module.exports = P24
