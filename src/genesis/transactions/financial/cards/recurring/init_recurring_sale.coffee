
CardBase         = require '../card_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
TravelData       = require '../../../../helpers/travel_data/travel_data'

class InitRecurringSale extends CardBase

  getTransactionType: ->
    TransactionTypes.INIT_RECURRING_SALE

  getTrxData: ->
    outboundParams = @getOutboundParams()
    travelData = new TravelData(outboundParams)
    travelData.parseTravelData()

    super(outboundParams)

module.exports = InitRecurringSale
