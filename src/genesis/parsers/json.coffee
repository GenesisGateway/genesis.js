# JSON Response Parser
class Json
  # JSON parser initialization
  constructor: ->
    @object        = {}
    @parseRootNode = false

  # Parsed Object to JSON
  getObject: ->
    @object

  # Remove root element from the parsed structure
  skipRootNode: ->
    @parseRootNode = true

  # Parse the given JSON object
  parseDocument: (document) ->
    if typeof document == 'string' || document instanceof String
      return @object = @processDocument(document)

    @object = document

  # Process the incoming JSON text document to JSON object
  processDocument: (document) ->
    try
      JSON.parse(document)
    catch
      {}

module.exports = Json
