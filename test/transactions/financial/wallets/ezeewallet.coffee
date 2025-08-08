faker           = require 'faker'
path            = require 'path'
_               = require 'underscore'
FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require '../../fake_data'
FinancialBase = require '../financial_base'
Transaction   = require path.resolve './src/genesis/transactions/financial/wallets/ezeewallet'

describe 'EzeeWallet Transaction', ->

  beforeEach ->
    fakeData                 = new FakeData()
    @data                    = fakeData.getSimpleData()
    @data.source_wallet_id   = faker.internet.email()
    @data.source_wallet_pwd  = Buffer.from(faker.internet.password()).toString('base64')
    @data.return_success_url = faker.internet.url()
    @data.return_failure_url = faker.internet.url()
    @data.merchant_website   = faker.internet.url()
    @data.notification_url   = faker.internet.url()
    delete @data.customer_email
    delete @data.customer_phone
    delete @data.remote_ip

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'when valid request', ->

    it 'with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'with minimum required parameters', ->
      data = _.clone @data
      delete data['usage']
      delete data['notification_url']
      assert.isTrue @transaction.setData(data).isValid()

  context 'when invalid request', ->
    describe 'when source_wallet_id', ->
      it 'fails with invalid email format', ->
        data = _.clone @data
        data['source_wallet_id'] = 'invalid-email'
        assert.isFalse @transaction.setData(data).isValid()

    describe 'when required fields are missing', ->
      requiredFields = [
        'source_wallet_id', 'source_wallet_pwd', 'return_success_url',
        'return_failure_url', 'merchant_website'
      ]

      for field in requiredFields
        do (field) =>
          it "fails when #{field} is missing", ->
            data = _.clone @data
            delete data[field]
            assert.isFalse @transaction.setData(data).isValid()

    describe 'when URLs', ->
      it 'fails with invalid return_success_url', ->
        data = _.clone @data
        data['return_success_url'] = 'invalid-url'
        assert.isFalse @transaction.setData(data).isValid()

      it 'fails with invalid return_failure_url', ->
        data = _.clone @data
        data['return_failure_url'] = 'invalid-url'
        assert.isFalse @transaction.setData(data).isValid()

      it 'fails with invalid merchant_website', ->
        data = _.clone @data
        data['merchant_website'] = 'invalid-url'
        assert.isFalse @transaction.setData(data).isValid()

  FinancialBase()

