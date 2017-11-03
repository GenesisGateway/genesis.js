
Validator = require './validator'
_         = require 'underscore'

###
  Validate if number is between given min and max numbers
###
class Number extends Validator

  constructor: (@min, @max) ->

  isValid: (value) ->

    if !_.isUndefined(@min) and value < @min
      return false
    else if !_.isUndefined(@max) and value > @max
      return false

    true

  getMessage: (field) ->

    if !_.isUndefined(@min) and _.isUndefined(@max)
      message_suffix = " Should be greater then #{@min}"
    else if _.isUndefined(@min) and !_.isUndefined(@max)
      message_suffix = " Should be lower then #{@max}"
    else
      message_suffix = " Should be between #{@min} and #{@max}"

    "Filed #{field} has invalid value." + message_suffix

module.exports = Number