faker = require 'faker'

FakeData      = require '../../fake_data'
FinancialBase = require '../financial_base'

SDDBase = () ->

  before ->
    @data           = (new FakeData).getApmData()
    @data['amount'] = faker.datatype.number({'min': 10, 'max': 24999.99}).toString()
    @data['billing_address']['country'] = faker.random.arrayElement(
      ['AT', 'BE', 'CY', 'EE', 'FI', 'FR', 'DE', 'GR', 'IE', 'IT', 'LV', 'LT', 'LU', 'MT', 'MC', 'NL', 'PT', 'SK', 'SM', 'SI', 'ES']
    )

  FinancialBase()

module.exports = SDDBase
