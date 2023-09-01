
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Poli extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.POLI

  constructor: (params) ->
    super params

module.exports = Poli
