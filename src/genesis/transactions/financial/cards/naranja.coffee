CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Naranja extends CardBase

  getTransactionType: ->
    TransactionTypes.NARANJA

module.exports = Naranja
