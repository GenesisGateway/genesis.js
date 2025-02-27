Response = require '../response'
Promise  = require 'bluebird'

class BaseRequestApi
  # Base Network constructor
  constructor: ->
    @responseBody    = ''
    @responseHeaders = {}
    @responseStatus  = 0
    @networkConfig   = {}

  # Provide Gateway Raw response payload
  getResponseBody: ->
    @responseBody

  # Provide Gateway response headers
  getResponseHeaders: ->
    @responseHeaders

  # Provide Gateway response HTTP Status Code
  getResponseStatus: ->
    @responseStatus

  # Content-Type of the received Response
  getResponseContentType: ->
    ''

  # Prepare Network Configurations based on the Request options
  prepareConfig: (requestOptions) ->
    @networkConfig = requestOptions

  # Loads the network object by the given gateway response
  initNetwork: ->
    throw Error("Init Network method must be implemented in the Network component!")
    @

  # Create Network request
  doRequest: (httpClient, requestObject) ->
    new Promise(
      ((resolve, reject) ->
        httpClient(requestObject
        ).then ((httpResponse) ->
          @initNetwork(httpResponse)

          resolve @initResponse().getResponseObject()
        ).bind(@)
          .catch ((errorObject) ->
            reject @parseErrorObject errorObject
        ).bind(@)
      ).bind(@)
    )

  parseErrorObject: (errorObject) ->
    if errorObject.response
      @initNetwork(errorObject.response)

      return {
        status: @getResponseStatus(),
        message: errorObject.response.statusText,
        response: @initResponse().getResponseObject()
      }
    if errorObject.request
      return {
        status: errorObject.code,
        message: 'No response received from hostname: ' + errorObject.hostname
        response: errorObject.response
      }
    return {
      status: 'Unknown',
      message: errorObject.message,
      response: undefined
    }

  # Load the Response with the Network object
  # TODO: Remove Response from the Network
  initResponse: ->
    new Response(@)

module.exports = BaseRequestApi
