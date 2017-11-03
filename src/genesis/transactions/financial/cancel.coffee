
FinancialBase    = require './financial_base'
TransactionTypes = require '../../helpers/transaction/types'

class Cancel extends FinancialBase

  getTransactionType: ->
    TransactionTypes.VOID

  constructor: (params) ->
    super params

    @requiredFields = [
      'transaction_id',
      'reference_id'
    ]

    @fieldsValues = {}

module.exports = Cancel