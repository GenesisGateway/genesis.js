
FinancialBase    = require '../../financial_base'
TransactionTypes = require '../../../../helpers/transaction/types'
_                = require 'underscore'
TravelData       = require '../../../../helpers/travel_data/travel_data'

class RecurringSale extends FinancialBase

  getTransactionType: ->
    TransactionTypes.RECURRING_SALE

  constructor: (params, configuration) ->
    super params, configuration


  getTrxData: ->
    travelData = new TravelData(@params)
    travelData.parseTravelData()

    super()

module.exports = RecurringSale
