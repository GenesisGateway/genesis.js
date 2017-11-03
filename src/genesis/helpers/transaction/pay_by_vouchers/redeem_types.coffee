_ = require 'underscore'

class RedeemTypes

  ###
    The amount value is stored in the voucher and can be used later on at any merchant outlet
    supporting the voucher card brand
  ###
  @STORED = 'stored';

  ###
    The voucher is issued, the amount value is transferred into it, and then immediately redeemed to the merchant
  ###
  @INSTANT = 'instant';

  getRedeemTypes: ->
    value for key, value of @constructor

  isValidRedeemType: (type) ->
    _.indexOf( @getRedeemTypes(), type ) != -1

module.exports = RedeemTypes