
CardBase          = require './card_base'
TransactionTypes  = require '../../../helpers/transaction/types'
_                 = require 'underscore'
TravelData        = require '../../../helpers/travel_data/travel_data'

class Authorize extends CardBase

  getTransactionType: ->
    TransactionTypes.AUTHORIZE

  getTrxData: ->
    travelData = new TravelData(@params)
    travelData.parseTravelData()

    super()

module.exports = Authorize
