path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../../fake_data'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/mobile/apple_pay'
FinancialBase      = require '../financial_base'
BusinessAttributes = require '../../business_attributes'
DynamicDescriptor  = require '../../../examples/attributes/financial/dynamic_descriptor'

describe 'Apple Pay Transaction', ->

  beforeEach ->
    @data                       = (new FakeData).getSimpleDataAndBusinessAttributes()
    @transaction                = new Transaction()

    @data['payment_subtype']    = 'authorize'
    @data['payment_token']      = (new FakeData).getApplePaymentTokenData()
    @data['birth_date']         = '20-10-2023'

  FinancialBase()
  BusinessAttributes()
  DynamicDescriptor()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with additional properties in token', ->
      data = _.clone(@data)
      data['payment_token']['randomProperty'] = "test"
      data['payment_token']['paymentData']['randomProperty'] = "test"

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with valid recurring_type', ->
      data = _.clone(@data)
      data['recurring_type'] = 'initial'

      assert.equal true, @transaction.setData(data).isValid()

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

    it 'fails without paymentData', ->
      data = _.clone(@data)
      delete data['payment_token']['paymentData']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without paymentMethod', ->
      data = _.clone(@data)
      delete data['payment_token']['paymentMethod']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without transactionIdentifier', ->
      data = _.clone(@data)
      delete data['payment_token']['transactionIdentifier']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without signedKey', ->
      data = _.clone(@data)
      delete data['payment_token']['paymentData']['version']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without data', ->
      data = _.clone(@data)
      delete data['payment_token']['paymentData']['data']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without signature', ->
      data = _.clone(@data)
      delete data['payment_token']['paymentData']['signature']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without header', ->
      data = _.clone(@data)
      delete data['payment_token']['paymentData']['header']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with invalid recurring_type', ->
      data = _.clone(@data)
      data['recurring_type'] = 'INVALID_VALUE'
