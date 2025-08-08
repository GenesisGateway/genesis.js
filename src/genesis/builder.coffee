Xml   = require './builders/xml'
Form  = require './builders/form'
Json  = require './builders/json'
Patch = require './builders/patch'

class Builder
  # XML Builder Identifier
  XML: 'xml'

  # JSON Builder Identifier
  JSON: 'json'

  # FORM Builder Identifier
  FORM: 'form'

  # JSON PATCH Builder Identifier
  PATCH: 'patch'

  constructor: (builderInterface) ->
    switch builderInterface
      when @XML
        @context = new Xml()
      when @FORM
        @context = new Form()
      when @JSON
        @context = new Json()
      when @PATCH
        @context = new Patch()
      else
        @context = null

  getDocument: (structure) ->
    return '' if @context == null

    @context.buildStructure(structure)

module.exports = Builder
