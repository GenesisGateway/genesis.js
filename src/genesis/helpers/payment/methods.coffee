_ = require 'underscore'

class Methods

  ###
    e-payment standard

    PPRO transaction
  ###
  @EPS = 'eps'

  ###
    iDEAL

    PPRO transaction
  ###
  @IDEAL = 'ideal'

  ###
    Przelewy24

    PPRO transaction
  ###
  @PRZELEWY24 = 'przelewy24'

  ###
    SafetyPay

    PPRO transaction
  ###
  @SAFETY_PAY = 'safetypay'

  ###
    TrustPay

    PPRO transaction
  ###
  @TRUST_PAY = 'trustpay'

  ###
    Mr.Cash

    PPRO transaction
  ###
  @BCMC = 'bcmc'

  ###
    MyBank

    PPRO transaction
  ###
  @MYBANK = 'mybank'

  getMethods: ->
    value for key, value of @constructor

  isValidMethod: (method) ->
    _.indexOf( @getMethods(), method ) != -1

module.exports = Methods
