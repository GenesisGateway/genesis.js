Xml  = require './parsers/xml'
Json = require './parsers/json'

# Response Parser wrapper
class Parser

  # XML Interface
  XML_INTERFACE: 'xml'

  # JSON interface
  JSON_INTERFACE: 'json'

  # Response Parser constructor
  constructor: (parserInterface = @XML_INTERFACE) ->
    @context = null
    @initParser(parserInterface)

  # Parsed document
  getObject: ->
    @context.getObject()

  # Skip first node of the parsed JSON object
  skipRootNode: ->
    @context.skipRootNode()

  # Parse the given document into JSON object
  parseDocument: (document) ->
    @context.parseDocument(document)

  # Parser factory
  initParser: (parserInterface) ->
    switch parserInterface
      when @JSON_INTERFACE then @context = new Json()
      when @XML_INTERFACE then @context = new Xml()
      else throw Error("Invalid Parser Interface given!")

module.exports = Parser
