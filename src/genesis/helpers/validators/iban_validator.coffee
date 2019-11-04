
Validator = require './validator'
_         = require 'underscore'

###
  Validate iban
###
class IbanValidator extends Validator

  NOT_STARTS_WITH_TWO_LETTERS: /^[^A-Z]{2}.*$/

  isValid: (value) ->
    value = String(value) # make sure we have string

    @messages = []

    if value.length > 34
      @messages.push 'Should be string shorter or equal 34'

    if value.match @NOT_STARTS_WITH_TWO_LETTERS
      @messages.push 'Should start with valid country code'

    if @messages.length
      return false

    true

  getMessage: (field) ->
    "Field #{field} has invalid value. #{@messages.join(' and ')}"

module.exports = IbanValidator
