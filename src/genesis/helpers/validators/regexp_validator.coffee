
Validator = require './validator'

class RegExpValidator extends Validator

  constructor: (pattern, message, options = '') ->
    super()
    @pattern = pattern
    @message = message
    @options = options

  isValid: (value) ->
    (new RegExp @pattern, @options).test(value)

  getMessage: (field) ->
    "Field #{field} has invalid value. Expected: #{@message}"

module.exports = RegExpValidator