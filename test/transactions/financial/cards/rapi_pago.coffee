faker           = require 'faker'
path            = require 'path'
_               = require 'underscore'
Currency        = require path.resolve './src/genesis/helpers/currency'
FakeConfig      = require path.resolve './test/transactions/fake_config'
FakeData        = require '../../fake_data'
AlternativeBase = require '../../financial/alternative/alternative_base.coffee'
Transaction     = require path.resolve './src/genesis/transactions/financial/obp/rapi_pago'

describe 'RapiPago Transaction', ->

  beforeEach ->
    fakeData     = new FakeData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data                         = fakeData.getMinimumData()
    @data.currency                = faker.random.arrayElement (new Currency).getCurrencies()
    @data.amount                  = faker.datatype.number().toString()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.return_pending_url      = faker.internet.url()
    @data.consumer_reference      = 'Consumer Reference'
    @data.national_id             = faker.finance.account(10)
    @data.birth_date              = '30-12-1992'
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'AR'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

  context 'when valid request', ->

    it 'with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'with minimum required parameters', ->
      data = _.clone @data
      delete data['usage']
      delete data['remote_ip']
      delete data['return_pending-url']
      delete data['birth_date']
      assert.isTrue @transaction.setData(data).isValid()

  context 'when invalid request', ->

    it 'fails with invalid country', ->
      data = _.clone @data
      data['billing_address']['country'] = 'NOT_VALID'
      assert.isFalse @transaction.setData(data).isValid()

    it 'fails when unsupported country', ->
      data = _.clone @data
      data['billing_address']['country'] = 'BG'
      assert.isFalse @transaction.setData(data).isValid()
      
    it 'fails with missing national_id', ->
      data = _.clone @data
      delete data['national_id']
      assert.isFalse @transaction.setData(data).isValid()

    it 'fails with missing consumer_reference', ->
      data = _.clone @data
      delete data['consumer_reference']
      assert.isFalse @transaction.setData(data).isValid()

  AlternativeBase()
