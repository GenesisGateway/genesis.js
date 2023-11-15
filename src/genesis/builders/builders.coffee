_    = require 'underscore'
Xml  = require './xml'
Form = require './form'

class Builders
  # XML Builder Identifier
  XML: 'xml'

  # JSON Builder Identifier
  JSON: 'json'

  # FORM Builder Identifier
  FORM: 'form'

  context: ''

  constructor: (builder) ->
    switch builder
      when @XML
        @context = new Xml()
      when @FORM
        @context = new Form()

  getBuilder: (structure) ->
    @context.getConverter(structure)





module.exports = Builders
