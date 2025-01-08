
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                    = require 'underscore'
TravelData       = require '../../../helpers/travel_data/travel_data'

class Sale extends CardBase

  getTransactionType: ->
    TransactionTypes.SALE

  getTrxData: ->
    travelData = new TravelData(@params)
    travelData.parseTravelData()

    super()

module.exports = Sale
