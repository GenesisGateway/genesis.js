
Validator = require './validator'
_         = require 'underscore'

###
  Validate if number is between given min and max numbers
###
class NumberValidator extends Validator

  constructor: (min = 0, max = 0) ->
    super()
    @min = min
    @max = max


  isValid: (value) ->
    if @min and value < @min
      return false
    else if @max and value > @max
      return false

    true

  getMessage: (field) ->
    if @min and @max == 0
      message_suffix = " Should be greater then #{@min}"

    else if @min == 0 and @max
      message_suffix = " Should be lower then #{@max}"

    else
      message_suffix = " Should be between #{@min} and #{@max}"

    "Field #{field} has invalid value.#{message_suffix}"

module.exports = NumberValidator