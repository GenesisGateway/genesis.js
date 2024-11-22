
FinancialBase = require '../financial_base'
_             = require 'underscore'
Country       = require '../../../helpers/country'

class AlternativeBase extends  FinancialBase

  constructor: (params, configuration) ->
    super params, configuration

module.exports = AlternativeBase
