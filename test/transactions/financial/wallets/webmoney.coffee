faker           = require 'faker'
path            = require 'path'
_               = require 'underscore'
FakeConfig      = require path.resolve './test/transactions/fake_config'
FakeData        = require '../../fake_data'
AlternativeBase = require '../../financial/alternative/alternative_base.coffee'
Transaction     = require path.resolve './src/genesis/transactions/financial/wallets/webmoney'

describe 'WebMoney Transaction', ->

  beforeEach ->
    fakeData                  = new FakeData()
    @data                     = fakeData.getSimpleData()
    @data.return_success_url  = faker.internet.url()
    @data.return_failure_url  = faker.internet.url()
    @data.is_payout           = faker.datatype.boolean().toString()
    @data.customer_account_id = faker.finance.account(12)
    @data.billing_address     = fakeData.getBillingData().billing_address
    @data.shipping_address    = fakeData.getShippingData().shipping_address

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'when valid request', ->

    it 'with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'with minimum required parameters', ->
      data = _.clone @data
      delete data['usage']
      delete data['is_payout']
      delete data['customer_phone']
      delete data['customer_account_id']
      delete data['shipping_address']
      assert.isTrue @transaction.setData(data).isValid()

  context 'when invalid request', ->
    describe 'when customer_account_id', ->
      it 'fails with longer customer_account', ->
        data = _.clone @data
        data['customer_account_id'] = faker.finance.account(15)
        assert.isFalse @transaction.setData(data).isValid()

  AlternativeBase()
