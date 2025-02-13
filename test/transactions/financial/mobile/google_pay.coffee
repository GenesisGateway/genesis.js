path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

BusinessAttributes = require '../../business_attributes'
DynamicDescriptor  = require '../../../examples/attributes/financial/dynamic_descriptor'
FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require '../../fake_data'
FinancialBase      = require '../financial_base'
Transaction        = require path.resolve './src/genesis/transactions/financial/mobile/google_pay'

describe 'GooglePay Transaction', ->

  beforeEach ->
    @data                       = (new FakeData).getSimpleDataAndBusinessAttributes()
    @transaction                = new Transaction(@data, FakeConfig.getConfig())

    @data['payment_subtype']    = 'authorize'
    @data['payment_token']      = (new FakeData).getGooglePaymentTokenData()
    @data['birth_date']         = '20-10-2023'


  FinancialBase()
  BusinessAttributes()
  DynamicDescriptor()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with valid recurring_type', ->
      data = _.clone(@data)
      data['recurring_type'] = 'initial'

  context 'with invalid request', ->

    it 'fails with invalid payment_subtype', ->
      data = _.clone(@data)
      data['payment_subtype'] = 'INVALID_VALUE'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without payment_token', ->
      data = _.clone(@data)
      delete data['payment_token']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without payment_subtype', ->
      data = _.clone(@data)
      delete data['payment_subtype']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without signature', ->
      data = _.clone(@data)
      delete data['payment_token']['signature']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without protocolVersion', ->
      data = _.clone(@data)
      delete data['payment_token']['protocolVersion']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without signedMessage', ->
      data = _.clone(@data)
      delete data['payment_token']['signedMessage']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without signedKey', ->
      data = _.clone(@data)
      delete data['payment_token']['intermediateSigningKey']['signedKey']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without signatures', ->
      data = _.clone(@data)
      delete data['payment_token']['intermediateSigningKey']['signatures']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with string payment_token', ->
      data = _.clone(@data)
      data['payment_token'] = faker.datatype.string(20)

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with empty payment_token', ->
      data = _.clone(@data)
      data['payment_token'] = ""

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid recurring_type', ->
      data = _.clone(@data)
      data['recurring_type'] = 'INVALID_VALUE'
