Response = require '../response'

class BaseRequestApi

  constructor: ->
    @response = new Response

  doRequest: (httpClient, requestObject) ->
    new Promise(
      ((resolve, reject) ->
        httpClient(requestObject
        ).then ((httpResponse) ->
          resolve @response.process httpResponse
        ).bind(@)
          .catch ((errorObject) ->
            reject @parseErrorObject errorObject
        ).bind(@)
      ).bind(@)
    )

  parseErrorObject: (errorObject) ->

    if errorObject.response
      return {
        status: errorObject.response.status,
        message: errorObject.response.statusText,
        response: @response.process errorObject.response
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

module.exports = BaseRequestApi
