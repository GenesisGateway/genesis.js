_         = require 'underscore'
JsonUtils            = require '../../utils/json_utils'

class TravelData

  constructor: (params) ->
    @params = params

  legs = ->
    _.extend(
      @params.travel,
        {
          legs:
            leg:
              @params.travel.legs
          }
        )

  taxes = ->
    _.extend(
      @params.travel,
        {
          taxes:
            tax:
              @params.travel.taxes
        }
      )

  parseTravelData: ->
    if JsonUtils.isValidObjectChain(@params, 'travel.legs')
      legs
    if JsonUtils.isValidObjectChain(@params, 'travel.taxes')
      taxes

module.exports = TravelData
