_    = require 'underscore'

class JsonUtils

  @isValidObjectChain: (object, chain) ->
    if not _.isObject(object) || _.isEmpty(chain)
      return false

    properties = chain.split('.')
    objectTmp = object

    for property in properties
      if not objectTmp[property] && not objectTmp.hasOwnProperty(property)
        return false

      objectTmp = objectTmp[property]

    return true

module.exports = JsonUtils
