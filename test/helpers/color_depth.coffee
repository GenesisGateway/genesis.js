path = require('path')

ColorDepth = require path.resolve './src/genesis/helpers/color_depth'

describe 'Color Depth', ->

  before ->
    @color_depth = new ColorDepth()

  it 'returns 0 when value equal 0', ->

    assert.equal 0, @color_depth.handleColorDepth(0)

  it 'returns 1 when value is between 1 and 3', ->

    assert.equal '1', @color_depth.handleColorDepth(3)

  it 'returns 4 when value is between 4 and 8', ->

    assert.equal '4', @color_depth.handleColorDepth(5)

  it 'returns 8 when value is between 8 and 15', ->

    assert.equal '8', @color_depth.handleColorDepth(10)

  it 'returns 16 when value is between 16 and 24', ->

    assert.equal '16', @color_depth.handleColorDepth(17)

  it 'returns 24 when value is between 24 and 32', ->

    assert.equal '24', @color_depth.handleColorDepth(30)

  it 'returns 32 when value is between 32 and 48', ->

    assert.equal '32', @color_depth.handleColorDepth(33)

  it 'returns 48 when value is greater than 48', ->

    assert.equal '48', @color_depth.handleColorDepth(100)

  it 'fails with value of null', ->

    assert.equal false, @color_depth.handleColorDepth(null)
