
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'
_ = require 'underscore'
TravelData       = require '../../../helpers/travel_data/travel_data'

class Authorize3d extends CardBase

  getTransactionType: ->
    TransactionTypes.AUTHORIZE_3D

  getTrxData: ->
    travelData = new TravelData(@params)
    travelData.parseTravelData()

    super()

module.exports = Authorize3d
