
CardBase    = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_           = require 'underscore'
TravelData  = require '../../../helpers/travel_data/travel_data'

class Sale3d extends CardBase

  getTransactionType: ->
    TransactionTypes.SALE_3D

  getTrxData: ->
    outboundParams = @getOutboundParams()
    travelData = new TravelData(outboundParams)
    travelData.parseTravelData()

    super(outboundParams)


module.exports = Sale3d
