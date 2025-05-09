_     = require 'underscore'
faker = require 'faker'

FakeConfig             = require '../../fake_config'
FakeData               = require '../../fake_data'
FinancialBase          = require '../../financial/financial_base'
RequiredBillingAddress = require '../../../examples/attributes/required_billing_address'
DynamicDescriptor      = require '../../../examples/attributes/financial/dynamic_descriptor'
Transaction            = require '../../../../src/genesis/transactions/financial/payout/sct_payout'

describe 'SCT Payout Transaction', ->

  beforeEach ->
    fakeData                      = new FakeData
    @data                         = fakeData.getSimpleData()
    @data.currency                = 'GHS'
    @data.amount                  = '10000'
    @data.iban                    = 'DE09100100101234567891'
    @data.bic                     = 'PBNKDEFFXXX'
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'HR'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

    delete @data.customer_email
    delete @data.customer_phone

    @transaction                  = new Transaction(@data, FakeConfig.getConfig())

  FinancialBase()
  RequiredBillingAddress()
  DynamicDescriptor()

  context 'when valid request', ->
    it 'with minimum required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  context 'when invalid request', ->
    it 'with invalid billing country', ->
      @data.billing_address.country = 'US'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without billing first_name', ->
      delete @data.billing_address.first_name

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without billing last_name', ->
      delete @data.billing_address.last_name

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without iban', ->
      delete @data.iban

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without bic', ->
      delete @data.bic

      assert.isNotTrue @transaction.setData(@data).isValid()

