
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Poli extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.POLI

  constructor: (params, configuration) ->
    super params, configuration

module.exports = Poli
