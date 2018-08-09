
AlternativeBase  = require '../alternative_base'
TransactionTypes = require '../../../../helpers/transaction/types'
DateValidator    = require '../../../../helpers/validators/date_validator'
_                = require 'underscore'

class Withdrawal extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.TRUSTLY_WITHDRAWAL

  constructor: (params) ->
    super params

    @requiredFields =
      _.union(
        @requiredFields,
        ['birth_date']
      )

    @fieldsValues =
      'birth_date': new DateValidator('DD-MM-YYYY')

module.exports = Withdrawal