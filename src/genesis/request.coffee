_        = require 'underscore'
fs       = require 'fs'
path     = require 'path'
util     = require 'util'
config   = require 'config'
js2xml   = require 'js2xmlparser'
request  = require 'request'
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

    js2xml rootNode, structure[rootNode]

  ###
    Send the transaction to the Gateway
  ###
  send: (params) ->

    args =
      agentOptions:
        # Explicitly state that we want to perform
        # certificate verification
        rejectUnauthorized: true
        # Force TLS1.2 as the only supported method.
        #
        # Note: Update if necessary
        secureProtocol: 'TLSv1_2_method'
      auth:
        username: config.customer.username
        password: config.customer.password
      body: @objToXml params.trx
      headers:
        'Content-Type': 'text/xml',
        'User-Agent': 'Genesis Node.js client v' + config.module.version
      strictSSL: true
      timeout: Number(config.gateway.timeout)
      url: @formatUrl params.url

    new Promise(
      ((resolve, reject) ->
        request.post args, ((error, httpResponse, responseBody) ->
          if error
            reject responseBody || error
          else
            respObj = @response.process httpResponse
            if respObj.status in ['declined', 'error']
              reject respObj
            else
              resolve respObj
        ).bind(@)
      ).bind(@)
    )

module.exports = Request
