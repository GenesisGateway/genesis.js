
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Sofort extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.SOFORT

  constructor: (params, configuration) ->
    super params, configuration

    @fieldsValues['billing_address.country'] = [
      'AT', 'BE', 'DE', 'ES', 'FR', 'GB', 'IT', 'NL', 'CH', 'PL'
    ]

module.exports = Sofort
