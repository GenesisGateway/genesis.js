Parser   = require './parser'
Currency = require './helpers/currency'

###
  Response - process, format and filters incoming Gateway response provided by the Network
###
class Response
  JSON_TYPE = 'application/json'

  constructor: (@network) ->
    @parser          = @initParser()
    @responseObject  = {}

    @processResponse()

    @

  # Raw Response
  getResponseRaw: ->
    @network.getResponseBody()

  # HTTP Response Code
  getResponseCode: ->
    @network.getResponseStatus()

  # Response Headers
  getResponseHeaders: ->
    @network.getResponseHeaders()

  # Return parsed Response JSON Object
  getResponseObject: ->
    @responseObject

  # Load the parser based on the Response Headers
  initParser: (parserInterface) ->
    return new Parser(Parser::JSON_INTERFACE) if @isResponseTypeJson(parserInterface)

    xmlParser = new Parser(Parser::XML_INTERFACE)
    xmlParser.skipRootNode()

    xmlParser

  # Determine if the given response has application/json payload
  isResponseTypeJson: ->
    return @network.getResponseContentType().indexOf(JSON_TYPE) >= 0

  # Attempt to process response from Genesis Payment Gateway
  processResponse: () ->
    @parser.parseDocument(@getResponseRaw())

    @responseObject = @parser.getObject()

    @transformObject()

  # Execute transformations on the Response Object
  transformObject: ->
    @transformCurrency()

  # Transform Currency inside the parsed Response Object
  transformCurrency: ->
    if @responseObject.hasOwnProperty('amount') and @responseObject.hasOwnProperty('currency')
      currency = @initCurrency()

      @responseObject.amount = currency.convertToNominalUnits(
        @responseObject.amount,
        @responseObject.currency
      )

    @

  # Initialize Currency helper used for response transformation
  initCurrency: ->
    new Currency()

module.exports = Response
