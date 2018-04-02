
Number = require './number'

class Amount extends Number

  constructor: () ->
    super()
    @min = 1
    @max = 100000000000

module.exports = Amount