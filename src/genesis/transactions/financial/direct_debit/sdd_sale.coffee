SddBase          = require './sdd_base'
TransactionTypes = require '../../../helpers/transaction/types'
StringValidator  = require '../../../helpers/validators/string_validator'
NumberValidator  = require '../../../helpers/validators/number_validator'
IbanValidator    = require '../../../helpers/validators/iban_validator'
BicValidator     = require '../../../helpers/validators/bic_validator'
_                = require 'underscore'

class SddSale extends SddBase

  getTransactionType: ->
    TransactionTypes.SDD_SALE

  constructor: (params) ->
    super params

module.exports = SddSale
