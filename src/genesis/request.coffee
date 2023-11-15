_         = require 'underscore'
fs        = require 'fs'
path      = require 'path'
util      = require 'util'
config    = require 'config'
https     = require 'https'
Response  = require './response'
Promise   = require 'bluebird'
Builders  = require './builders/builders'
AxiosApi  = require './network/axios_api'
Validator = require './transactions/validator'

class Request

  ENVIRONMENT_PREFIX_PRODUCTION = ''
  ENVIRONMENT_PREFIX_STAGING = 'staging'

  METHOD_POST : 'POST'
  METHOD_PUT  : 'PUT'

  constructor: (builderInterface = 'xml') ->
    @builderInterface = builderInterface
    @builderContext = (new Builders(@builderInterface))
    @response = new Response

  initConfiguration: ->
    @loadBuilderInterface()

  getArguments: ->

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
      util.format '%s://%s%s.%s/%s/%s'
      , config.gateway.protocol
      , @getURLEnvironment()
      , params.app
      , config.gateway.hostname
      , params.path
      , params.token
    else
      util.format '%s://%s%s.%s/%s'
      , config.gateway.protocol
      , @getURLEnvironment()
      , params.app
      , config.gateway.hostname
      , params.path

  ###
    Send the transaction to the Gateway
  ###
  send: () ->
    if !@isValid()
      return Promise.reject @getValidationErrorResponse()

    params        = @getArguments()
    requestConfig = @initConfiguration @builderInterface
    data          = @builderContext.getBuilder params.trx
    axiosApi      = new AxiosApi

    axiosApi.request_query((@formatUrl params.url), requestConfig, data)

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

  getURLEnvironment: () ->
    return if config.gateway.testing
    then ENVIRONMENT_PREFIX_STAGING + '.'
    else ENVIRONMENT_PREFIX_PRODUCTION

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
