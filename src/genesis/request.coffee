_             = require 'underscore'
fs            = require 'fs'
path          = require 'path'
util          = require 'util'
config        = require 'config'
https         = require 'https'
Response      = require './response'
Promise       = require 'bluebird'
Builders      = require './builders/builders'
AxiosApi      = require './network/axios_api'
Validator     = require './transactions/validator'
Domains       = require './constants/domains'
Environments = require './constants/environments'
JsonUtils    = require './utils/json_utils'

class Request

  METHOD_POST : 'POST'
  METHOD_PUT  : 'PUT'

  constructor: (builderInterface = 'xml') ->
    @builderInterface = builderInterface
    @builderContext = (new Builders(@builderInterface))
    @response = new Response

  initConfiguration: ->
    @loadBuilderInterface()

  getArguments: ->

  getUrl: ->
    app:
      ''
    path:
      ''
    token:
      ''

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
      , config.gateway.protocol
      , @getURLEnvironment(params.app)
      , config.gateway.hostname
      , params.path
      , params.token
    else
      util.format '%s://%s.%s/%s'
      , config.gateway.protocol
      , @getURLEnvironment(params.app)
      , config.gateway.hostname
      , params.path

  ###
    Send the transaction to the Gateway
  ###
  send: () ->
    configValidation = @validateConfiguration(@getUrl().app)

    if typeof configValidation == "object"
      return Promise.reject configValidation

    if !@isValid()
      return Promise.reject @getValidationErrorResponse()

    params        = @getArguments()
    requestConfig = @initConfiguration @builderInterface
    data          = @builderContext.getBuilder params.trx
    axiosApi      = new AxiosApi

    axiosApi.request_query((@formatUrl params.url), requestConfig, data)

  validateConfiguration: (app) ->
    if !JsonUtils.isValidObjectChain(Domains.SUBDOMAINS, app)
      return @getEnvironmentErrorMessage()

    return true

  initXmlConfiguration: ->
    method: @METHOD_POST
    httpsAgent: new https.Agent({
      rejectUnauthorized: true
      maxVersion: "TLSv1.2"
      minVersion: "TLSv1.2"
    })
    headers:
      'Content-Type': 'text/xml'
      'User-Agent': 'Genesis Node.js client v' + config.module.version
      'Authorization': 'Basic ' +
        Buffer.from(
          config.customer.username + ':' + config.customer.password
        ).toString('base64')
    timeout: Number(config.gateway.timeout)
    validateStatus: (status) ->
      status >= 200 && status < 300

  initFormConfiguration: ->
    method: @METHOD_PUT
    headers:
      'Content-Type': 'application/x-www-form-urlencoded'

  getURLEnvironment: (app) ->
    return if config.gateway.testing
    then Domains.SUBDOMAINS[app][Environments.STAGING]
    else Domains.SUBDOMAINS[app][Environments.PRODUCTION]

  isValid: () ->
    # Sanitize the parameters
    @sanitizeParams(@params)

    @validator = new Validator(this)
    return @validator.isValid()

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

  getForceSmartRouter: ->
    config.customer.force_smart_routing

module.exports = Request
