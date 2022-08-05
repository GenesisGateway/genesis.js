
Request   = require '../request'
Currency  = require '../helpers/currency'
_         = require 'underscore'
Promise   = require 'bluebird'
Validator = require './validator'

class Base

  constructor: (@params) ->
    @request  = new Request
    @currency = new Currency

  setData: (@params) ->
    @

  getData: () ->
    if @getTransactionType?()
      _.extend(
        {},
        @params,
        transaction_type: @getTransactionType()
      )
    else
      @params

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

  send: () ->
    if !@isValid()
      return Promise.reject @getValidationErrorResponse()

    args =
      trx:
        @getTrxData()
      url:
        @getUrl()

    @request.send args

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

module.exports = Base
