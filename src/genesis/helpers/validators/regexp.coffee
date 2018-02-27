
Validator = require './validator'

class RegExpValidator extends Validator

  constructor: (@pattern, @message, @options = '') ->

  isValid: (value) ->
    (new RegExp @pattern, @options).test(value)

  getMessage: (field) ->
    "Filed #{field} has invalid value. Expected: #{@message}"

module.exports = RegExpValidator