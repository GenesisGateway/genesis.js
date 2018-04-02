RegExpValidator  = require './regexp'

class CreditCard

  constructor: (field) ->

    @validators =
      'card_holder':
        new RegExpValidator '^[\\w\'\-,.]+[ ]+[\\w\'\-,. ]+$', 'full name' , 'u'
      'card_number':
        new RegExpValidator '^[0-9]{13,19}$', 'number with 13 to 19 digits'
      'cvv':
        new RegExpValidator '^[0-9]{3,4}$', 'number with 3 to 4 digits'
      'expiration_month':
        new RegExpValidator '^(0?[1-9]|1[012])$', 'valid month number (ex: 05)'
      'expiration_year':
        new RegExpValidator '^(20)\\d{2}$', 'valid year number (ex: 2021)'

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
