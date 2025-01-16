_                 = require 'underscore'
AxiosApi          = require './network/axios_api'
Builders          = require './builders/builders'
Currency          = require './helpers/currency'
Domains           = require './constants/domains'
Environments      = require './constants/environments'
https             = require 'https'
JsonUtils         = require './utils/json_utils'
util              = require 'util'
Promise           = require 'bluebird'
Response          = require './response'
Validator         = require './transactions/validator'

class Request

  METHOD_POST : 'POST'
  METHOD_PUT  : 'PUT'

  constructor: (@params, configuration, builderInterface = 'xml') ->
    @builderInterface = builderInterface
    @builderContext   = (new Builders(@builderInterface))
    @response         = new Response
    @configuration    = configuration
    @axiosApi         = new AxiosApi
    @currency         = new Currency

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
      when 'xml'
        @initXmlConfiguration()
      when 'form'
        @initFormConfiguration()

  ###
    Format and return the endpoint URL based on the transaction parameters
  ###
  formatUrl: (params) ->
    if params.token
      util.format '%s://%s.%s/%s/%s'
      , @configuration.getGatewayProtocol()
      , @getURLEnvironment(params.app)
      , @configuration.getGatewayHostname()
      , params.path
      , params.token
    else
      util.format '%s://%s.%s/%s'
      , @configuration.getGatewayProtocol()
      , @getURLEnvironment(params.app)
      , @configuration.getGatewayHostname()
      , params.path

  ###
    Send the transaction to the Gateway
  ###
  send: () ->
    if !@isValid()
      return Promise.reject @getValidationErrorResponse()

    params           = @getArguments()
    configValidation = @validateConfiguration(params.url.app)

    if typeof configValidation == "object"
      return Promise.reject configValidation

    if !@isValidConfig()
      return Promise.reject @getValidationErrorResponse()

    requestConfig = @initConfiguration @builderInterface
    data          = @builderContext.getBuilder params.trx

    @axiosApi.request_query((@formatUrl params.url), requestConfig, data)

  validateConfiguration: (app) ->
    if !JsonUtils.isValidObjectChain(Domains.SUBDOMAINS, app)
      return @getEnvironmentErrorMessage()

    return true

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
      'Authorization': 'Basic ' +
        Buffer.from(
          @configuration.getCustomerUsername() + ':' + @configuration.getCustomerPassword()
        ).toString('base64')
    timeout: Number(@configuration.getGatewayTimeout())
    validateStatus: (status) ->
      status >= 200 && status < 300

  initFormConfiguration: ->
    method: @METHOD_PUT
    headers:
      'Content-Type': 'application/x-www-form-urlencoded'

  getURLEnvironment: (app) ->
    return if (@configuration.getGatewayTesting())
    then Domains.SUBDOMAINS[app][Environments.STAGING]
    else Domains.SUBDOMAINS[app][Environments.PRODUCTION]

  isValid: () ->
    # Sanitize the parameters
    @sanitizeParams(@params)

    @validator = new Validator @
    return @validator.isValid()

  isValidConfig: () ->
    @validator = new Validator @
    return @validator.isValidConfig()

  getErrors: ->
    @validator.getErrors()

  getValidationErrorResponse: ->
    return {
      "status": "INVALID_INPUT"
      "message": "Please verify the transaction parameters and check input data for errors.",
      "response": @getErrors()
    }

  getEnvironmentErrorMessage: ->
    return {
      "status": "INVALID_INPUT"
      "message": "Please verify request APP parameters. Use one for the following: " + Object.keys(Domains.SUBDOMAINS).join(", ")
      "response": []
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

module.exports = Request
