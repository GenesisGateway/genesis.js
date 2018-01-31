
Validator = require './validator'
moment    = require 'moment'

class Date extends Validator

  constructor: (@format = 'YYYY-MM-DD') ->

  isValid: (value) ->
    moment(value, @format, true).isValid()

  getMessage: (field) ->
    "Filed #{field} has invalid date format. Excepted format is #{@format}"

module.exports = Date