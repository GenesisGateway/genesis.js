path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../../fake_data'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/wallets/pay_pal'
FinancialBase      = require '../financial_base'
BusinessAttributes = require '../../business_attributes'

describe 'PayPal Transaction', ->

  beforeEach ->
    @data                       = (new FakeData).getSimpleDataAndBusinessAttributes()
    @transaction                = new Transaction()

    @data['birth_date']         = '20-10-2020'
    @data['payment_type']       = 'authorize'


  FinancialBase()
  BusinessAttributes()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails with invalid payment_type', ->
      data = _.clone(@data)
      data['payment_type'] = 'INVALID_VALUE'

      assert.equal false, @transaction.setData(data).isValid()
