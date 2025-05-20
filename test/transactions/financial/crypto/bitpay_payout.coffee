faker             = require 'faker'
path              = require 'path'
_                 = require 'underscore'
FakeConfig        = require path.resolve './test/transactions/fake_config'
FakeData          = require '../../fake_data'
FinancialExamples = require '../financial_base'
Transaction       = require path.resolve './src/genesis/transactions/financial/crypto/bitpay_payout'

describe 'BitPay Payout Transaction', ->

  beforeEach ->
    fakeData     = new FakeData()
    
    @data                         = fakeData.getMinimumData()
    @data.currency                = 'USD'
    @data.amount                  = '100'
    @data.notification_url        = faker.internet.url()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.customer_email          = faker.internet.email()
    @data.crypto_address          = faker.datatype.uuid()
    @data.crypto_wallet_provider  = faker.random.arrayElement(
      [ "other", "bitgo", "uphold", "circle", "coinbase", "gdax", "gemini", "itbit", "kraken" ]
    )
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'FR'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  context 'with invalid request', ->

    it 'fails with invalid country code', ->
      @data.billing_address.country = 'INVALID'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid currency code', ->
      @data.currency = 'BGN'

      assert.isNotTrue @transaction.setData(@data).isValid()
    
    it 'fails with missing notification_url parameter', ->
      delete @data.notification_url

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid notification_url parameter', ->
      @data.notification_url = 'INVALID_VALUE'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing return_success_url parameter', ->
      delete @data.return_success_url

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid return_success_url parameter', ->
      @data.return_success_url = 'INVALID_VALUE'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing return_failure_url parameter', ->
      delete @data.return_failure_url

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid return_failure_url parameter', ->
      @data.return_failure_url = 'INVALID_VALUE'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid customer_email parameter', ->
      @data.customer_email = 'INVALID_VALUE'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid crypto_address parameter', ->
      delete @data.crypto_address

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid crypto_wallet_provider parameter', ->
      @data.crypto_wallet_provider = 'INVALID_VALUE'

      assert.isNotTrue @transaction.setData(@data).isValid()


  FinancialExamples()
