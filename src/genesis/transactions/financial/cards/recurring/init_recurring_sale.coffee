
CardBase         = require '../card_base'
TransactionTypes = require '../../../../helpers/transaction/types'

class InitRecurringSale extends CardBase

  getTransactionType: ->
    TransactionTypes.INIT_RECURRING_SALE

module.exports = InitRecurringSale