
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Authorize extends CardBase

  getTransactionType: ->
    TransactionTypes.AUTHORIZE

module.exports = Authorize