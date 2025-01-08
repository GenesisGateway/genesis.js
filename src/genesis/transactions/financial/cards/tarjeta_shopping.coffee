CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class TarjetaShopping extends CardBase

  getTransactionType: ->
    TransactionTypes.TARJETA_SHOPPING

module.exports = TarjetaShopping
