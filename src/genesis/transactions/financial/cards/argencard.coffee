CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Argencard extends CardBase

  getTransactionType: ->
    TransactionTypes.ARGENCARD

module.exports = Argencard
