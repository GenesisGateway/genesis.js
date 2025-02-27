Xml  = require './builders/xml'
Form = require './builders/form'
Json = require './builders/json'

class Builder
  # XML Builder Identifier
  XML: 'xml'

  # JSON Builder Identifier
  JSON: 'json'

  # FORM Builder Identifier
  FORM: 'form'

  constructor: (builderInterface) ->
    switch builderInterface
      when @XML
        @context = new Xml()
      when @FORM
        @context = new Form()
      when @JSON
        @context = new Json()
      else
        @context = null

  getDocument: (structure) ->
    return '' if @context == null

    @context.buildStructure(structure)

module.exports = Builder
