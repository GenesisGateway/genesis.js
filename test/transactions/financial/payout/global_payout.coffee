_     = require 'underscore'
faker = require 'faker'

FakeConfig             = require '../../fake_config'
FakeData               = require '../../fake_data'
FinancialBase          = require '../../financial/financial_base'
RequiredBillingAddress = require '../../../examples/attributes/required_billing_address'
Transaction            = require '../../../../src/genesis/transactions/financial/payout/global_payout'

describe 'Global Payout Transaction', ->

  beforeEach ->
    fakeData                      = new FakeData
    @data                         = fakeData.getMinimumData()
    @data.currency                = 'EUR'
    @data.amount                  = '100'
    @data.payee_account_id        = faker.datatype.uuid()
    @data.billing_address         = fakeData.getBillingData().billing_address

    @transaction                  = new Transaction(@data, FakeConfig.getConfig())

  FinancialBase()
  RequiredBillingAddress()

  context 'when valid request', ->
    it 'with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  context 'when invalid request', ->
    it 'without payee_account_id', ->
      delete @data.payee_account_id

      assert.isNotTrue @transaction.setData(@data).isValid()
