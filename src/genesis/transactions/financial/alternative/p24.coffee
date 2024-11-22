
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class P24 extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.P24

  constructor: (params, configuration) ->
    super params, configuration

module.exports = P24
