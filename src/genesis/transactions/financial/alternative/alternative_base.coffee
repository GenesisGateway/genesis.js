
FinancialBase = require '../financial_base'
_             = require 'underscore'
Country       = require '../../../helpers/country'

class AlternativeBase extends  FinancialBase

  constructor: (params) ->
    super params

module.exports = AlternativeBase
