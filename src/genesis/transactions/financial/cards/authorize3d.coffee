
CardBase         = require './card_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Authorize3d extends CardBase

  getTransactionType: ->
    TransactionTypes.AUTHORIZE_3D

  constructor: (params) ->
    super params

    @set3DRequiredFields()

module.exports = Authorize3d