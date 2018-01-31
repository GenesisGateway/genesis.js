
AlternativeBase  = require './alternative_base'
TransactionTypes = require '../../../helpers/transaction/types'
PaymentMethods   = require '../../../helpers/payment/methods'
_                = require 'underscore'

class PPRO extends AlternativeBase

  getTransactionType: ->
    TransactionTypes.PPRO

  constructor: (params) ->
    super params

    @paymentMethods = new PaymentMethods

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'payment_type',
        ]
      )

    @fieldsValues['payment_type'] = @paymentMethods.getMethods()

    @requiredFieldsConditional =
      'payment_type':
        "#{PaymentMethods.GIRO_PAY}":
          ['bic', 'iban']
        "#{PaymentMethods.PRZELEWY24}":
          ['customer_email']
        "#{PaymentMethods.QIWI}":
          ['account_phone']

    @fieldsValuesConditional =
      'payment_type':
        "#{PaymentMethods.EPS}":
          'billing_address.country': 'AT'
          'currency': 'EUR'
        "#{PaymentMethods.TELEINGRESO}":
          'billing_address.country': 'ES'
          'currency': 'EUR'
        "#{PaymentMethods.SAFETY_PAY}":
          'billing_address.country': ['CA', 'MX', 'NI', 'CR', 'PA', 'CO', 'PE', 'BR', 'NL']
          'currency': ['EUR', 'USD']
        "#{PaymentMethods.TRUST_PAY}":
          'billing_address.country': ['CZ', 'SK']
          #'currency': ['CZK', 'EUR']
        "#{PaymentMethods.PRZELEWY24}":
          'billing_address.country': 'PL'
          'currency': 'PLN'
        "#{PaymentMethods.IDEAL}":
          'billing_address.country': 'NL'
          'currency': 'EUR'
        "#{PaymentMethods.QIWI}":
          'billing_address.country': 'RU'
          'currency': ['EUR', 'RUB']
        "#{PaymentMethods.GIRO_PAY}":
          'billing_address.country': 'DE'
          'currency': 'EUR'
        "#{PaymentMethods.BCMC}":
          'billing_address.country': 'BE'
          'currency': 'EUR'
        "#{PaymentMethods.MYBANK}":
          'billing_address.country': ['BE', 'FR', 'IT', 'LU']
          'currency': 'EUR'

      'billing_address.country':
        'CZ':
          'payment_type':
            "#{PaymentMethods.TRUST_PAY}":
              'currency': 'CZK'
        'SK':
          'payment_type':
            "#{PaymentMethods.TRUST_PAY}":
              'currency': 'EUR'

module.exports = PPRO