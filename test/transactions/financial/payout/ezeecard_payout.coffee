path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require path.resolve './test/transactions/fake_data'
FinancialBase      = require path.resolve './test/transactions/financial/financial_base'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/payout/ezeecard_payout'

describe 'eZeeCard Payout Transaction', ->

  beforeEach ->
    fakeData           = new FakeData
    @data              = fakeData.getSimpleData()
    @data.reference_id = faker.datatype.uuid()
    delete @data.customer_email
    delete @data.customer_phone

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  FinancialBase()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with only required parameters', ->
      data = _.clone(@data)
      delete data['remote_ip']
      delete data['usage']
      assert.isTrue @transaction.setData(@data).isValid()

  context 'with invalid request', ->
    it 'with missing reference_id', ->
      data = _.clone(@data)
      delete data['reference_id']
      assert.isNotTrue @transaction.setData(data).isValid()
