
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'

class Paysafecard extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.PAYSAFECARD

  constructor: (params) ->
    super params

    @fieldsValues['billing_address.country'] = [
      'AT', 'BE', 'CY', 'CZ', 'DK', 'FI', 'FR', 'DE', 'GR', 'IE', 'IT', 'LU'
      'NL', 'NO', 'PL', 'PT', 'RO', 'SK', 'SI', 'ES', 'SE', 'CH', 'GB', 'HU'
      'HR', 'MT', 'US', 'CA', 'MX', 'TR', 'AE'
    ]

module.exports = Paysafecard