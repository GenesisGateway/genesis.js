path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Currency               = require path.resolve './src/genesis/helpers/currency'
FakeConfig             = require path.resolve './test/transactions/fake_config'
FakeData               = require '../../fake_data'
FinancialBase          = require '../financial_base'
RequiredBillingAddress = require '../../../examples/attributes/required_billing_address'
Transaction            = require path.resolve './src/genesis/transactions/financial/obp/pse'

describe 'PSE Transaction', ->

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
    @data.national_id             = '8812128812'
    @data.birth_date              = '30-12-1992'
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'CO'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data                         = _.clone @data
      data.billing_address.country = 'CO'
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when optional return_pending_url', ->
      data                         = _.clone @data
      delete data.return_pending_url
      assert.equal true, @transaction.setData(data).isValid()

    it 'works when optional birth_date', ->
      data                         = _.clone @data
      delete data.birth_date
      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when return_success_url missing', ->
      data = _.clone @data
      delete data.return_success_url
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when return_failure_url missing', ->
      data = _.clone @data
      delete data.return_failure_url
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when consumer_reference missing', ->
      data = _.clone @data
      delete data.consumer_reference
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when national_id missing', ->
      data = _.clone @data
      delete data.national_id
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when not supported country parameter added', ->
      data = _.clone @data
      data.billing_address.country = 'AT'
      assert.equal false, @transaction.setData(data).isValid()

  FinancialBase()
  RequiredBillingAddress()
