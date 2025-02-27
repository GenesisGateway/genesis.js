axios            = require 'axios'
https            = require 'https'
BaseRequestApi   = require './base_request_api'
{ AxiosHeaders } = require 'axios'

###
  Axios Network Adapter
###
class AxiosApi extends BaseRequestApi
  # Axios Adapter constructor
  constructor: ->
    super()
    @instance = axios.create()

  # Provide Gateway response headers
  getResponseHeaders: ->
    return @responseHeaders unless @responseHeaders instanceof AxiosHeaders

    @responseHeaders.toJSON()

  # Provide Gateway response Content-Type
  getResponseContentType: ->
    return '' unless @responseHeaders instanceof AxiosHeaders

    @responseHeaders.get('content-type').toLowerCase()

  # Load the Network object from the gateway response
  initNetwork: (networkObject) ->
    @responseBody    = networkObject.data
    @responseHeaders = networkObject.headers
    @responseStatus  = parseInt(networkObject.status)

    @

  # Prepare Axios request configuration
  prepareConfig: (requestOptions) ->
    @networkConfig = Object.assign(@defaultConfig(), requestOptions)

  # Send the Request
  send: (url, params) ->
    @doRequest(@instance, @prepareRequestData(url, params))

  # Default Axios request configuration
  defaultConfig: ->
    httpsAgent: new https.Agent({
      rejectUnauthorized: true
      maxVersion: "TLSv1.2"
      minVersion: "TLSv1.2"
    })
    responseType: 'text'
    validateStatus: (status) ->
      status >= 200 && status < 300

  # Prepare Axios request data
  prepareRequestData: (url, params) ->
    Object.assign({ url: url, data: params }, @networkConfig)

module.exports = AxiosApi
