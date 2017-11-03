
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Sale extends CardBase

  getTransactionType: ->
    TransactionTypes.SALE

module.exports = Sale