_            = require 'underscore'
ThreedsUtils = require '../../../../../utils/threeds_utils'
Request      = require '../../../../../request'
Currency     = require '../../../../../helpers/currency'
TransactionTypes = require '../../../../../helpers/transaction/types'

class MethodContinue extends Request

  THREEDS_METHOD_URL: 'threeds/threeds_method/'

  constructor: (@params, configuration) ->
    super('form', configuration)
    @currency = new Currency
    @configuration = configuration

  getTransactionType: ->
    TransactionTypes.METHOD_CONTINUE

  setData: (@params) ->
    @

  ###
     Returns SHA512 hash of а concatenated string (unique_id, amount, timestamp, customer.password)
  ###
  getSignature: ->
    @params.amount = @currency.convertToMinorUnits @params.amount, @params.currency
    ThreedsUtils.generateSignature @params.unique_id, @params.amount, @params.timestamp, @configuration.getCustomerPassword()

  ###
    Returns relative path with provided unique_id
  ###
  getRelativePath =  ->
    @THREEDS_METHOD_URL + @params.unique_id

  getData: () ->
    @params

  getTrxParams: ->
    unique_id: @params.unique_id
    signature: @getSignature()

  getArguments:() ->
    trx:
      @getTrxParams()
    url:
      app:
        'gate'
      path:
        getRelativePath.call(@)

module.exports = MethodContinue
