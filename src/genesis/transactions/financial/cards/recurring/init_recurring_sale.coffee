
CardBase         = require '../card_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
TravelData       = require '../../../../helpers/travel_data/travel_data'

class InitRecurringSale extends CardBase

  getTransactionType: ->
    TransactionTypes.INIT_RECURRING_SALE

  getTrxData: ->
    travelData = new TravelData(@params)
    travelData.parseTravelData()

    super()

module.exports = InitRecurringSale
