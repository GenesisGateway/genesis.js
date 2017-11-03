
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class P24 extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.P24

  constructor: (params) ->
    super params

    @fieldsValues['billing_address.country'] = [
      'AD', 'AT', 'BE', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'EL', 'ES', 'NL',
      'IE', 'IS', 'LT', 'LV', 'LU', 'MT', 'DE', 'NO', 'PL', 'PT', 'SM', 'SK',
      'SI', 'CH', 'SE', 'HU', 'GB', 'IT', 'US', 'CA', 'JP', 'UA', 'BY', 'RU'
    ]

module.exports = P24