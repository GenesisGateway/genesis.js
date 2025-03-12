_         = require 'underscore'
AxiosApi  = require './networks/axios_api'
Builder   = require './builder'
Currency  = require './helpers/currency'
Promise   = require 'bluebird'
util      = require 'util'
Validator = require './transactions/validator'

###
  Base Gateway Request - Build the Request and send it to the Network
###
class Request

  METHOD_POST : 'POST'
  METHOD_PUT  : 'PUT'
  METHOD_GET  : 'GET'

  constructor: (@params, configuration, builderInterface = 'xml') ->
    @builderInterface = builderInterface
    @builderContext   = new Builder @builderInterface
    @configuration    = configuration
    @network          = new AxiosApi
    @currency         = new Currency
    @validator        = new Validator @

  # Load Request Network configuration
  initConfiguration: ->
    @loadBuilderInterface()

  # Helper method
  # TODO: Request.setData should be removed
  setData: (@params) ->
    @

  # Accessor for @params
  getData: () ->
    @params

  # Build the Network request data based on specific Gateway Request
  getArguments: ->
    url:
      @getUrl()
    trx:
      @getTrxData()

  # Gateway Endpoint that each request defines
  getUrl: ->
    app:
      ''
    path:
      ''
    token:
      ''

  # Payment transaction structure that each request defines along with given params
  getTrxData: ->
    {}

  # Load Request Network options based on the Gateway endpoint requirements
  loadBuilderInterface: ->
    switch @builderInterface
      when @builderContext.XML then @initXmlConfiguration()
      when @builderContext.FORM then @initFormConfiguration()
      when @builderContext.JSON then @initJsonConfiguration()
      else @initGetConfiguration()

  # Format and return the endpoint URL based on the transaction parameters
  formatUrl: (params) ->
    util.format '%s://%s.%s/%s'
    , @configuration.getGatewayProtocol()
    , @configuration.getSubDomain(params.app)
    , @configuration.getGatewayHostname()
    , if params.token? then "#{params.path}/#{params.token}" else params.path

  # Send the Request to the Gateway
  send: () ->
    if !@isValid()
      return Promise.reject @getValidationErrorResponse()

    params = @getArguments()

    @network.prepareConfig @initConfiguration()
    @network.send @formatUrl(params.url), @builderContext.getDocument(params.trx)

  # Load XML Post Network Configuration
  initXmlConfiguration: ->
    options         = Object.assign { method: @METHOD_POST }, @getDefaultNetworkOptions()
    options.headers = Object.assign options.headers, 'Content-Type': 'text/xml'

    options

  # Load FORM Put Network Configuration
  initFormConfiguration: ->
    options         = Object.assign { method: @METHOD_PUT }, @getDefaultNetworkOptions()
    options.headers = Object.assign(
      options.headers,
      'Content-Type': 'application/x-www-form-urlencoded'
    )

    options

  # Load JSON Post Network Configuration
  initJsonConfiguration: ->
    options         = Object.assign { method: @METHOD_POST }, @getDefaultNetworkOptions()
    options.headers = Object.assign options.headers, 'Content-Type': 'application/json'

    options

  # Load Get Network Configuration
  initGetConfiguration: ->
    Object.assign { method: @METHOD_GET }, @getDefaultNetworkOptions()

  # Validate Request requirements
  isValid: () ->
    if !@validator.isValidConfig()
      return false

    # Sanitize the parameters
    @sanitizeParams(@params)

    if !@validator.isValid()
      return false

    return true

  # Provides validation errors
  getErrors: ->
    @validator.getErrors()

  # Provides consolidated error response upon error
  getValidationErrorResponse: ->
    return {
      "status": "INVALID_INPUT"
      "message": "Please verify the transaction parameters and check input data for errors.",
      "response": @getErrors()
    }

  # Removes empty elements from the payment structure
  sanitizeParams: (rawParams) ->
    _this = @
    _.each rawParams, (value, field) ->
      if (_.isArray(value) || _.isObject(value))
        _this.sanitizeParams(value)

      if (
        (
          _.isEmpty(value) && ((not _.isNumber(value)) && (not _.isBoolean(value)))
        ) || _.isNull(value)
      )
        delete rawParams[field]

  # Default Request Network configuration
  getDefaultNetworkOptions: ->
    headers:
      'User-Agent': "Genesis Node.js client v#{@configuration.getVersion()}"
      'Authorization': @getAuthorizationHeader()
    timeout: @configuration.getGatewayTimeout()

  # Build Authorization header
  getAuthorizationHeader: ->
    credentials = "#{@configuration.getCustomerUsername()}:#{@configuration.getCustomerPassword()}"

    "Basic #{Buffer.from(credentials).toString('base64')}"

module.exports = Request
