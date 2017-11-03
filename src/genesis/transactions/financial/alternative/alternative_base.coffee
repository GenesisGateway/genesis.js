
FinancialBase = require '../financial_base'
_             = require 'underscore'
Country       = require '../../../helpers/country'

class AlternativeBase extends  FinancialBase

  constructor: (params) ->
    super params

    @country = new Country

    @requiredFields =
      _.union(
        @requiredFields,
        [
          'remote_ip',
          'return_success_url',
          'return_failure_url',
          'customer_email',
          'billing_address.country'
        ]
      )

    @fieldsValues['billing_address.country'] = @country.getCountries()

module.exports = AlternativeBase