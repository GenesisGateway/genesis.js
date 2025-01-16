faker                  = require 'faker'
path                   = require 'path'
_                      = require 'underscore'
FakeData               = require '../../fake_data'
Transaction            = require path.resolve './src/genesis/transactions/financial/cards/bancontact'
FinancialExamples      = require '../financial_base'
RequiredBillingAddress = require '../../../examples/attributes/required_billing_address'

describe 'Bancontact Transaction', ->

  beforeEach ->
    fakeData     = new FakeData()
    @transaction = new Transaction()

    @data                         = fakeData.getMinimumData()
    @data.currency                = 'EUR'
    @data.amount                  = faker.datatype.number().toString()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'BE'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

  context 'with invalid request', ->

    it 'fails with unsupported currency and country', ->
      data = _.clone @data
      data['currency'] = 'USD'
      data['billing_address']['country'] = 'BG'

      assert.equal false, @transaction.setData(data).isValid()

  context 'with valid request', ->

    it 'works when valid parameters added', ->
      data = _.clone @data
      data['currency'] = 'EUR'
      data['billing_address']['country'] = 'BE'

      assert.equal true, @transaction.setData(data).isValid()

  FinancialExamples()
  RequiredBillingAddress()
