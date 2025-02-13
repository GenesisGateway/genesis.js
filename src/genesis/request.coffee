_         = require 'underscore'
AxiosApi  = require './network/axios_api'
Builders  = require './builders/builders'
Currency  = require './helpers/currency'
https     = require 'https'
Promise   = require 'bluebird'
Response  = require './response'
util      = require 'util'
Validator = require './transactions/validator'

class Request

  METHOD_POST : 'POST'
  METHOD_PUT  : 'PUT'
  METHOD_GET  : 'GET'

  constructor: (@params, configuration, builderInterface = 'xml') ->
    @builderInterface = builderInterface
    @builderContext   = (new Builders(@builderInterface))
    @response         = new Response
    @configuration    = configuration
    @axiosApi         = new AxiosApi
    @currency         = new Currency
    @validator        = new Validator @

  initConfiguration: ->
    @loadBuilderInterface()

  setData: (@params) ->
    @

  getData: () ->
    @params

  getArguments: ->
    trx:
      @getTrxData()
    url:
      @getUrl()

  getUrl: ->
    app:
      ''
    path:
      ''
    token:
      ''

  getTrxData: ->

  loadBuilderInterface: ->
    switch @builderInterface
      when @builderContext.XML
        @initXmlConfiguration()
      when @builderContext.FORM
        @initFormConfiguration()
      else
        @initGetConfiguration()

  ###
    Format and return the endpoint URL based on the transaction parameters
  ###
  formatUrl: (params) ->
    util.format '%s://%s.%s/%s'
    , @configuration.getGatewayProtocol()
    , @configuration.getSubDomain(params.app)
    , @configuration.getGatewayHostname()
    , if params.token? then "#{params.path}/#{params.token}" else params.path

  ###
    Send the transaction to the Gateway
  ###
  send: () ->
    if !@isValid()
      return Promise.reject @getValidationErrorResponse()

    params        = @getArguments()
    requestConfig = @initConfiguration @builderInterface
    data          = @builderContext.getBuilder params.trx

    @axiosApi.request_query((@formatUrl params.url), requestConfig, data)

  initXmlConfiguration: ->
    version = @configuration.getVersion()

    method: @METHOD_POST
    httpsAgent: new https.Agent({
      rejectUnauthorized: true
      maxVersion: "TLSv1.2"
      minVersion: "TLSv1.2"
    })
    headers:
      'Content-Type': 'text/xml'
      'User-Agent': 'Genesis Node.js client v' + version
      'Authorization': @getAuthorizationHeader()
    timeout: Number(@configuration.getGatewayTimeout())
    validateStatus: (status) ->
      status >= 200 && status < 300

  initFormConfiguration: ->
    method: @METHOD_PUT
    headers:
      'Content-Type': 'application/x-www-form-urlencoded'

  initGetConfiguration: ->
    method: @METHOD_GET
    headers:
      'User-Agent': 'Genesis Node.js client v' + @configuration.getVersion()
      'Authorization': @getAuthorizationHeader()

  isValid: () ->
    if !@validator.isValidConfig()
      return false

    # Sanitize the parameters
    @sanitizeParams(@params)

    if !@validator.isValid()
      return false

    return true

  getErrors: ->
    @validator.getErrors()

  getValidationErrorResponse: ->
    return {
      "status": "INVALID_INPUT"
      "message": "Please verify the transaction parameters and check input data for errors.",
      "response": @getErrors()
    }

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

  getAuthorizationHeader: ->
    'Basic ' +
      Buffer.from(
        @configuration.getCustomerUsername() + ':' + @configuration.getCustomerPassword()
      ).toString('base64')

module.exports = Request
