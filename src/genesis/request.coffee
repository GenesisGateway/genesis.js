_        = require 'underscore'
fs       = require 'fs'
path     = require 'path'
util     = require 'util'
config   = require 'config'
js2xml   = require 'js2xmlparser'
axios    = require 'axios'
https    = require 'https'
Response = require './response'
Promise  = require 'bluebird'

class Request

  constructor: ->
    @response = new Response

  ###
    Format and return the endpoint URL based on the transaction parameters
  ###
  formatUrl: (params) ->
    prefix = if config.gateway.testing then 'staging.' else new String

    if params.token
      util.format '%s://%s%s.%s/%s/%s'
      , config.gateway.protocol
      , prefix
      , params.app
      , config.gateway.hostname
      , params.path
      , params.token
    else
      util.format '%s://%s%s.%s/%s'
      , config.gateway.protocol
      , prefix
      , params.app
      , config.gateway.hostname
      , params.path

  ###
    Convert Object to XML structure
  ###
  objToXml: (structure) ->
    rootNode = _.first _.keys(structure)

    js2xml.parse rootNode, structure[rootNode]

  ###
    Send the transaction to the Gateway
  ###
  send: (params) ->

    requestConfig =
      method: 'POST'
      httpsAgent: new https.Agent({
        rejectUnauthorized: true,
        maxVersion: "TLSv1.2",
        minVersion: "TLSv1.2"
      })
      headers:
        'Content-Type': 'text/xml',
        'User-Agent': 'Genesis Node.js client v' + config.module.version
        'Authorization': 'Basic ' +
          Buffer.from(
            config.customer.username + ':' + config.customer.password
          ).toString('base64')
      timeout: Number(config.gateway.timeout)
      validateStatus: (status) ->
        status >= 200 && status < 300

    new Promise(
      ((resolve, reject) ->
        axios.post(
          (@formatUrl params.url),
          (@objToXml params.trx),
          requestConfig
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
        response: this.response.process errorObject.response
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

module.exports = Request
