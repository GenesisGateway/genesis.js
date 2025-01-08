
FinancialBase    = require '../financial_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'
NumberValidator  = require '../../../helpers/validators/number_validator'

class Wechat extends FinancialBase

  getTransactionType: ->
    TransactionTypes.WECHAT

module.exports = Wechat
