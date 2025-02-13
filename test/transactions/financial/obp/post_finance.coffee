path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig             = require path.resolve './test/transactions/fake_config'
FakeData               = require '../../fake_data'
FinancialBase          = require '../financial_base'
RequiredBillingAddress = require '../../../examples/attributes/required_billing_address'
Transaction            = require path.resolve './src/genesis/transactions/financial/obp/post_finance'

describe 'PostFinance Transaction', ->

  beforeEach ->
    @data                         = (new FakeData).getApmData()
    delete @data.customer_email
    delete @data.customer_phone
    @data.currency                = 'CHF'
    @data.billing_address.country = "CH"
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.return_pending_url      = faker.internet.url()
    @transaction                  = new Transaction(@data, FakeConfig.getConfig())

  FinancialBase()
  RequiredBillingAddress()

  context 'with valid request', ->

    it 'work when currency and country parameters added', ->
      data                         = _.clone @data
      data.currency                = "CHF"
      data.billing_address.country = "CH"
      assert.equal true, @transaction.setData(data).isValid()

    it 'works with base required parameters', ->
      data = _.clone @data
      delete data.usage
      delete data.remote_ip
      delete data.shipping_address
      delete data.return_pending_url
      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when wrong country parameter added', ->
      data                         = _.clone @data
      data.billing_address.country = 'NOT_VALID_COUNTRY'
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when country parameter missing', ->
      data = _.clone @data
      delete data.billing_address.country
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when wrong country parameter added', ->
      data                               = _.clone @data
      data.billing_address.country = 'AU'
      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when wrong combination of currency/country used', ->
      data                         = _.clone @data
      data.billing_address.country = "PL"
      data.currency                = "CZK"
      assert.equal false, @transaction.setData(data).isValid()
