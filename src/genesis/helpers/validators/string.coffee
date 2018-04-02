
Validator = require './validator'
_         = require 'underscore'

###
  Validate if string length is between given min and max length
###
class String extends Validator

  constructor: (min, max) ->
    super()
    @min = min
    @max = max

  isValid: (value) ->

    if !_.isUndefined(@min) and value.length <= @min
      return false
    else if !_.isUndefined(@max) and value.length >= @max
      return false

    true

  getMessage: (field) ->

    if !_.isUndefined(@min) and _.isUndefined(@max)
      message_suffix = "longer or equal #{@min}"
    else if _.isUndefined(@min) and !_.isUndefined(@max)
      message_suffix = "shorter or equal #{@max}"
    else
      message_suffix = "between #{@min} and #{@max}"

    "Filed #{field} has invalid value. Should be string " + message_suffix + " characters"

module.exports = String