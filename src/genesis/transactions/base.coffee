Request   = require '../request'
Currency  = require '../helpers/currency'
_         = require 'underscore'
Promise   = require 'bluebird'
Validator = require './validator'

class Base extends Request

  constructor: (@params) ->
    super('xml')
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

  getArguments: ->
    trx:
      @getTrxData()
    url:
      @getUrl()

module.exports = Base
