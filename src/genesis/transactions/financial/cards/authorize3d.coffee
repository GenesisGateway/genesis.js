
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_ = require 'underscore'
TravelData       = require '../../../helpers/travel_data/travel_data'

class Authorize3d extends CardBase

  getTransactionType: ->
    TransactionTypes.AUTHORIZE_3D

  getTrxData: ->
    outboundParams = @getOutboundParams()
    travelData = new TravelData(outboundParams)
    travelData.parseTravelData()

    super(outboundParams)

module.exports = Authorize3d
