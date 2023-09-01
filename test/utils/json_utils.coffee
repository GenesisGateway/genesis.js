path = require('path')

JsonUtils = require path.resolve './src/genesis/utils/json_utils'

describe 'Json Utils', ->

  it 'works with proper object and chan', ->

    object = {
      main: {
        sub: {
          property: "test"
        }
      }
    }
    chain = "main.sub.property"

    assert.equal true, JsonUtils.isValidObjectChain(object, chain)

  it 'fails when added property in chain that missing in object', ->
    object = {
      main: {
        sub: "test"
      }
    }
    chain = "main.sub.property"

    assert.equal false, JsonUtils.isValidObjectChain(object, chain)

  it 'fails when added string instead of object', ->
    object = "test"
    chain = "main.sub.property"

    assert.equal false, JsonUtils.isValidObjectChain(object, chain)

  it 'fails when added empty string instead of chain', ->
    object = {
      main: {
        sub: "test"
      }
    }
    chain = ""

    assert.equal false, JsonUtils.isValidObjectChain(object, chain)

  it 'fails when added null instead of chain', ->
    object = {
      main: {
        sub: "test"
      }
    }
    chain = null

    assert.equal false, JsonUtils.isValidObjectChain(object, chain)

  it 'fails when added null instead of object', ->
    object = null
    chain = "main.sub.property"

    assert.equal false, JsonUtils.isValidObjectChain(object, chain)

  it 'works with boolean value', ->
    object = {
      main: {
        sub: false
      }
    }

    assert.equal true, JsonUtils.isValidObjectChain(object, 'main.sub')

  it 'works with integer value', ->
    object = {
      main: {
        sub: 10
      }
    }

    assert.equal true, JsonUtils.isValidObjectChain(object, 'main.sub')


