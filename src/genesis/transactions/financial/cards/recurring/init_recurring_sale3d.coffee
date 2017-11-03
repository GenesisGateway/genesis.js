
CardBase         = require '../card_base'
TransactionTypes = require '../../../../helpers/transaction/types'

class InitRecurringSale3d extends CardBase

  getTransactionType: ->
    TransactionTypes.INIT_RECURRING_SALE_3D

  constructor: (params) ->
    super params

    @set3DRequiredFields()

module.exports = InitRecurringSale3d