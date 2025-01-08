CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Bancontact extends CardBase

  getTransactionType: ->
    TransactionTypes.BANCONTACT

module.exports = Bancontact
