
NumberValidator = require './number_validator'

class AmountValidator extends NumberValidator

  constructor: () ->
    super()
    @min = 0.01
    @max = 1000000000.00

module.exports = AmountValidator