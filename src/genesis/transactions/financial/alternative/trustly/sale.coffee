
AlternativeBase  = require '../alternative_base'
TransactionTypes = require '../../../../helpers/transaction/types'

class Sale extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.TRUSTLY_SALE

  constructor: (params) ->
    super params

    @fieldsValues['billing_address.country'] = [
      'AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU',
      'IE', 'IT', 'LT', 'LU', 'LV', 'MT', 'NL', 'NO', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK'
    ]

module.exports = Sale