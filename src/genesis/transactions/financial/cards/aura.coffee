CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Aura extends CardBase

  getTransactionType: ->
    TransactionTypes.AURA

module.exports = Aura
