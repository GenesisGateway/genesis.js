
class CreditCard

  constructor: (field) ->

    @validators =
      'card_holder':
        new RegExp '^[\\w\'\-,.]+[ ]+[\\w\'\-,. ]+$', 'u'
      'card_number':
        new RegExp '^[0-9]{13,19}$'
      'cvv':
        new RegExp '^[0-9]{3,4}$'
      'expiration_month':
        new RegExp '^(0?[1-9]|1[012])$'
      'expiration_year':
        new RegExp '^(20)\\d{2}$'

    if field and @validators[field]
      return @validators[field]

  getCCRequiredFields: ->
    [
      'card_holder',
      'card_number',
      'expiration_month',
      'expiration_year'
    ]

  getCCFieldValueFormatValidators: ->
    @validators

module.exports = CreditCard