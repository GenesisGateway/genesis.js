path  = require 'path'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/business/kyc_create_business'

describe 'KYC Create Business Request', ->

  beforeEach ->
    @data = {
      registration_number: faker.datatype.number().toString()
      country:             faker.address.countryCode()
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'with json builder interface', ->
    assert.equal @transaction.builderInterface, 'json'

  it 'fails when missing required parameters', ->
    delete @data.registration_number
    delete @data.country
    assert.isNotTrue @transaction.setData(@data).isValid()

  it 'works with all required parameters', ->
    assert.isTrue @transaction.setData(@data).isValid()

  it 'works with all parameters', ->
    @data.name = faker.company.companyName()
    assert.isTrue @transaction.setData(@data).isValid()

  it 'fails with invalid country value', ->
    @data.country = 'invalid_value'
    assert.isNotTrue @transaction.setData(@data).isValid()

  Base()
