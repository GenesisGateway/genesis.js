
FinancialBase       = require '../financial_base'
_                   = require 'underscore'

class CardBase extends FinancialBase

  constructor: (params) ->
    super params

  isValid: () ->
    valid = super()

    if not _.isEmpty(@params.token) && @params.remember_card == true
      @validator.addError
        type: 'oneOf'
        property: 'remember_card token'
        message: 'Request depends on specific rules. ' +
          'Only one of the following parameters can exists in the request: token or remember_card'
      false

    valid

module.exports = CardBase
