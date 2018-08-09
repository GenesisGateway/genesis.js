Validator = require './validator'
_         = require 'underscore'

###
  Validate if string length is between given min and max length
###
class StringValidator extends Validator

  constructor: (min = 0, max = 0) ->
    super()
    @min = min
    @max = max

  isValid: (value) ->
    if @min and value.length < @min
      return false
    else if @max and value.length > @max
      return false

    true

  getMessage: (field) ->
    if @min and @max == 0
      message_suffix = "longer or equal #{@min}"

    else if @min == 0 and @max
      message_suffix = "shorter or equal #{@max}"

    else
      message_suffix = "between #{@min} and #{@max}"

    "Field #{field} has invalid value. Should be string #{message_suffix} characters"

module.exports = StringValidator