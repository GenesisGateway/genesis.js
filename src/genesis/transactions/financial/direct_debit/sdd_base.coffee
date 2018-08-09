FinancialBase    = require '../financial_base'
NumberValidator  = require '../../../helpers/validators/number_validator'
_                = require 'underscore'

class SddBase extends FinancialBase

  constructor: (params) ->
    super params

    @fieldsValues =
      _.extend(
        @fieldsValues,
        'amount':
          new NumberValidator 10, 24999.99
      )

module.exports = SddBase
