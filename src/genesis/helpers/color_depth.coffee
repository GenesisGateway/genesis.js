_  = require "underscore"

class ColorDepth

  constructor: ->
    @colorDepth =
      'BIT_1'  : 1,
      'BITS_4' : 4,
      'BITS_8' : 8,
      'BITS_15': 15,
      'BITS_16': 16,
      'BITS_24': 24,
      'BITS_32': 32,
      'BITS_48': 48

  getColorDepth: ->
    _.values @colorDepth

  handleColorDepth: (colorDepthValue) ->
    if colorDepthValue == null
      return false

    if colorDepthValue > 0
      return (@getColorDepth().filter (x) -> x <= colorDepthValue).reverse()[0]

    return colorDepthValue

module.exports = ColorDepth
