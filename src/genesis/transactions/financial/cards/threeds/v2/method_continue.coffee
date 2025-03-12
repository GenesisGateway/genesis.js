_                = require 'underscore'
Request          = require '../../../../../request'
ThreedsUtils     = require '../../../../../utils/threeds_utils'
TransactionTypes = require '../../../../../helpers/transaction/types'

class MethodContinue extends Request

  THREEDS_METHOD_URL: 'threeds/threeds_method/'

  constructor: (params, configuration) ->
    super(params, configuration, 'form')

  getTransactionType: ->
    TransactionTypes.METHOD_CONTINUE

  ###
     Returns SHA512 hash of а concatenated string (unique_id, amount, timestamp, customer.password)
  ###
  getSignature: ->
    @params.amount = @currency.convertToMinorUnits @params.amount, @params.currency
    ThreedsUtils.generateSignature(
      @params.unique_id,
      @params.amount,
      @params.timestamp,
      @configuration.getCustomerPassword()
    )

  ###
    Returns relative path with provided unique_id
  ###
  getRelativePath =  ->
    @THREEDS_METHOD_URL + @params.unique_id

  getTrxData: ->
    unique_id: @params.unique_id
    signature: @getSignature()

  getUrl: ->
    app:
      'gate'
    path:
      getRelativePath.call(@)


module.exports = MethodContinue
