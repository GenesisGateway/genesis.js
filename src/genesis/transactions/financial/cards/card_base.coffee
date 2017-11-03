
FinancialBase       = require '../financial_base'
_                   = require 'underscore'
CreditCardValidator = require '../../../helpers/validators/credit_card'

class CardBase extends  FinancialBase

  constructor: (params) ->
    super params

    creditCardValidator = new CreditCardValidator

    @requiredFields =
      _.union(
        @requiredFields,
        creditCardValidator.getCCRequiredFields()
      )

    @fieldsValues =
      _.extend(
        @fieldsValues,
        creditCardValidator.getCCFieldValueFormatValidators()
      )

  set3DRequiredFields: ->
    @requiredFieldsGroups =
      'asynchronous':
        ['notification_url', 'return_success_url', 'return_failure_url']
      'synchronous':
        ['mpi_params.eci']

module.exports = CardBase