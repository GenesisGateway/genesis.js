
CardBase          = require './card_base'
TransactionTypes  = require '../../../helpers/transaction/types'
_                 = require 'underscore'
TravelData        = require '../../../helpers/travel_data/travel_data'

class Authorize extends CardBase

  getTransactionType: ->
    TransactionTypes.AUTHORIZE

  getTrxData: ->
    outboundParams = @getOutboundParams()
    travelData = new TravelData(outboundParams)
    travelData.parseTravelData()

    super(outboundParams)

module.exports = Authorize
