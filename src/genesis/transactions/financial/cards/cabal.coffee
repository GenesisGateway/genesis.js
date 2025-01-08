CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Cabal extends CardBase

  getTransactionType: ->
    TransactionTypes.CABAL

module.exports = Cabal
