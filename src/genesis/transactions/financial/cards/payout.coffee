
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Payout extends CardBase

  getTransactionType: ->
    TransactionTypes.PAYOUT

module.exports = Payout