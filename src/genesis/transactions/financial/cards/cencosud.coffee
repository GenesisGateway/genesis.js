CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Cencosud extends CardBase

  getTransactionType: ->
    TransactionTypes.CENCOSUD

module.exports = Cencosud
