faker = require 'faker'

FakeData      = require '../../fake_data'
FinancialBase = require '../financial_base'

SDDBase = () ->

  before ->
    @data           = (new FakeData).getApmData()
    @data['amount'] = faker.datatype.number({"min": 10, "max": 24999.99}).toString()

  FinancialBase()

module.exports = SDDBase
