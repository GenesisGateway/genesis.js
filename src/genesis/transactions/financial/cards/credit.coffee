
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Credit extends FinancialBase

  getTransactionType: ->
    TransactionTypes.CREDIT

  constructor: (params) ->
    super params

    @requiredFields = [
      'reference_id'
    ]

    @fieldsValues = {}

module.exports = Credit