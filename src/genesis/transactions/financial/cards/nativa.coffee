CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Nativa extends CardBase

  getTransactionType: ->
    TransactionTypes.NATIVA

module.exports = Nativa
