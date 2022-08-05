SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'
_                = require 'underscore'

class SddRefund extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_REFUND

  constructor: (params) ->
    super params

module.exports = SddRefund
