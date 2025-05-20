faker             = require 'faker'
path              = require 'path'
_                 = require 'underscore'
FakeConfig        = require path.resolve './test/transactions/fake_config'
FakeData          = require '../../fake_data'
FinancialExamples = require '../financial_base'
Transaction       = require path.resolve './src/genesis/transactions/financial/crypto/bitpay_refund'

describe 'BitPay Refund Transaction', ->

  beforeEach ->
    fakeData     = new FakeData()
    
    @data              = fakeData.getMinimumData()
    @data.currency     = 'BGN'
    @data.amount       = '100'
    @data.reference_id = faker.datatype.number().toString()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  context 'with invalid request', ->

    it 'fails without reference_id', ->
      delete @data.reference_id

      assert.isNotTrue @transaction.setData(@data).isValid()

  FinancialExamples()
