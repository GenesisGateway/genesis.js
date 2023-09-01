
CardBase    = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_           = require 'underscore'
TravelData  = require '../../../helpers/travel_data/travel_data'


class Sale3d extends CardBase

  getTransactionType: ->
    TransactionTypes.SALE_3D

  getTrxData: ->
    travelData = new TravelData(@params)
    travelData.parseTravelData()

    super()


module.exports = Sale3d
