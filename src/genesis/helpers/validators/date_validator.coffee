
Validator = require './validator'
moment    = require 'moment'

class DateValidator extends Validator

  constructor: (format = 'YYYY-MM-DD') ->
    super()
    @format = format

  isValid: (value) ->
    moment(value, @format, true).isValid()

  getMessage: (field) ->
    "Field #{field} has invalid date format. Expected format is #{@format}"

module.exports = DateValidator