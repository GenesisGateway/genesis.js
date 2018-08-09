Validator = require './validator'
_         = require 'underscore'

###
  Validate bic
###
class BicValidator extends Validator

  NOT_CHARACTERS_IN_FIRST_SIX: /^[^A-Z]{6}.*$/

  isValid: (value) ->
    value = String(value); # make sure we have string

    @messages = []

    if value.length < 8 || value.length > 11
      @messages.push 'Should be string between 8 and 11 characters'

    if value.match @NOT_CHARACTERS_IN_FIRST_SIX
      @messages.push 'Should include only characters in the first 6 positions'

    if @messages.length
      return false

    true

  getMessage: (field) ->
    "Field #{field} has invalid value. #{@messages.join(' and ')}"

module.exports = BicValidator
