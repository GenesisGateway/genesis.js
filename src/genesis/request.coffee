_         = require 'underscore'
fs        = require 'fs'
path      = require 'path'
util      = require 'util'
config    = require 'config'
js2xml    = require 'js2xmlparser'
request   = require 'request'
xml2json  = require 'xml2json'

Response  = require './response'

class Request

  constructor: ->
    @callback = {}

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
    Handle the callback
  ###
  handleCallback: (error, httpResponse, responseBody) =>
    if error
      @callback.failure error, httpResponse, responseBody

    respObj = @response.process httpResponse

    if respObj.status in ['declined', 'error']
      @callback.failure respObj.technical_message, respObj
    else
      @callback.success httpResponse, respObj

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
    # Save the callbacks for later use
    @callback = params.callbacks

    args =
      agentOptions:
        # Array with the Root certificates used
        # to verify the app servers
        #
        # Note: Update if necessary
        ca: [
          fs.readFileSync(
            path.join __dirname, '../../assets/certificates/addtrust_external_root.pem'
          ),
          fs.readFileSync(
            path.join __dirname, '../../assets/certificates/symantec_class_3_ev_ca.pem'
          ),
          fs.readFileSync(
            path.join __dirname, '../../assets/certificates/verisign_class_3_primary_certification_authority.pem'
          ),
          fs.readFileSync(
            path.join __dirname, '../../assets/certificates/verisign_universal_root_certification_authority.pem'
          ),
        ]
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

    request.post args, @handleCallback

module.exports = Request