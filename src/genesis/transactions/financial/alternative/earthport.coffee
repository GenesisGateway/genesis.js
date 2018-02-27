
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class Earthport extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.EARTHPORT

  constructor: (params) ->
    super params

    @requiredFields = [
      'transaction_id',
      'amount',
      'currency',
      'customer_email',
      'account_name',
      'bank_name',
      'billing_address.first_name',
      'billing_address.last_name',
      'billing_address.address1',
      'billing_address.city',
      'billing_address.country'
    ]

    @requiredFieldsConditional =
      'billing_address.country':
        'AD': ['iban', 'bic']
        'AU': ['account_number', 'bank_code', 'branch_code']
        'AT': ['iban', 'bic']
        'BH': ['iban', 'bic']
        'BS': ['iban', 'bic']
        'BE': ['iban', 'bic']
        'BG': ['iban', 'bic']
        'CA': ['account_number', 'bank_code', 'branch_code', 'billing_address.state']
        'CY': ['iban', 'bic']
        'CZ': ['iban', 'bic']
        'DK': ['iban', 'bic']
        'EG': ['account_number', 'bic']
        'EE': ['iban', 'bic']
        'FI': ['iban', 'bic']
        'FR': ['iban', 'bic']
        'DE': ['iban', 'bic']
        'GR': ['iban', 'bic']
        'HK': ['account_number', 'bank_code', 'branch_code', 'account_number_suffix']
        'HU': ['iban', 'bic']
        'ID': ['account_number', 'bank_code', 'branch_code']
        'IE': ['iban', 'bic']
        'IL': ['iban', 'bic']
        'IT': ['iban', 'bic']
        'JP': ['iban', 'bic']
        'KE': ['iban', 'bic']
        'LV': ['iban', 'bic']
        'LI': ['iban', 'bic']
        'LT': ['iban', 'bic']
        'LU': ['iban', 'bic']
        'MY': ['account_number', 'bic']
        'MT': ['iban', 'bic']
        'MA': ['account_number']
        'NL': ['iban', 'bic']
        'NZ': ['account_number', 'bank_code', 'branch_code', 'account number suffix']
        'NO': ['iban', 'bic']
        'PK': ['iban', 'bic']
        'PH': ['account_number', 'bank_code']
        'PL': ['iban', 'bic']
        'PT': ['iban', 'bic']
        'RO': ['iban', 'bic']
        'SG': ['account_number', 'bank_code', 'branch_code']
        'SK': ['iban', 'bic']
        'SI': ['iban', 'bic']
        'ES': ['iban', 'bic']
        'SE': ['account_number', 'bank_code', 'bic']
        'CH': ['iban', 'bic']
        'GB': ['account_number', 'sort_code']
        'US': ['account_number', 'aba_routing_number', 'billing_address.state']
        'VN': ['account_number', 'bic']

    @fieldsValues['billing_address.country'] =  _.keys @requiredFieldsConditional['billing_address.country']

module.exports = Earthport