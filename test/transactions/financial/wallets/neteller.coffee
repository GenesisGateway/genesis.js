faker           = require 'faker'
path            = require 'path'
_               = require 'underscore'
FakeConfig      = require path.resolve './test/transactions/fake_config'
FakeData        = require '../../fake_data'
AlternativeBase = require '../../financial/alternative/alternative_base.coffee'
Transaction     = require path.resolve './src/genesis/transactions/financial/wallets/neteller'

describe 'Neteller Transaction', ->

  beforeEach ->
    fakeData                 = new FakeData()
    @data                    = fakeData.getSimpleData()
    @data.return_success_url = faker.internet.url()
    @data.return_failure_url = faker.internet.url()
    @data.customer_account   = faker.finance.account()
    @data.account_password   = faker.finance.account(6)
    @data.billing_address    = fakeData.getBillingData().billing_address
    @data.shipping_address   = fakeData.getShippingData().shipping_address

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'when valid request', ->

    it 'with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'with minimum required parameters', ->
      data = _.clone @data
      delete data['usage']
      delete data['customer_phone']
      assert.isTrue @transaction.setData(data).isValid()

  context 'when invalid request', ->
    describe 'when customer account', ->
      it 'fails with missing customer_account', ->
        data = _.clone @data
        delete data['customer_account']
        assert.isFalse @transaction.setData(data).isValid()

      it 'fails with longer customer_account', ->
        data = _.clone @data
        data['customer_account'] = faker.finance.account(111)
        assert.isFalse @transaction.setData(data).isValid()

    describe 'when account_password', ->
      it 'fails with missing account_password', ->
        data = _.clone @data
        delete data['account_password']
        assert.isFalse @transaction.setData(data).isValid()

      it 'fails with longer account_password', ->
        data = _.clone @data
        data['account_password'] = faker.finance.account(10)
        assert.isFalse @transaction.setData(data).isValid()

  AlternativeBase()
