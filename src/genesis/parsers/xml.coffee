_             = require 'underscore'
{ XMLParser } = require 'fast-xml-parser'

# XML Response Parser
class Xml
  # XML parser initialization
  constructor: () ->
    @object        = {}
    @parseRootNode = false
    @fastXmlParser = new XMLParser(
      ignoreDeclaration:   true
      ignoreAttributes:    false
      attributeNamePrefix: ''
    )


  # Parsed Object to JSON
  getObject: ->
    @object

  # Remove root element from the parsed structure
  skipRootNode: ->
    @parseRootNode = true

  # Parse the given XML document
  parseDocument:(document) ->
    @object = @processDocument(document)
    @object = @removeFirstNode(@object) if @parseRootNode

    @object

  # Process the incoming XML document to JSON
  processDocument: (document) ->
    try
      @fastXmlParser.parse(document)
    catch
      {}

  # Remove the firstChild as its usually just a single node
  removeFirstNode: ->
    keysCount = _.keys(@object).length

    return @object[_.first _.keys(@object)] if keysCount == 1 && @object[_.keys(@object)[0]] instanceof Object

    @object

module.exports = Xml
