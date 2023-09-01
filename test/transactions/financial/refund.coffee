path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData      = require '../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/financial/refund'
FinancialBase = require './financial_base'

describe 'Refund Transaction', ->

  before ->
    @data        = (new FakeData).getSimpleData()
    @transaction = new Transaction()

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  FinancialBase()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()

  it 'fails when wrong bank_acount_type given', ->
#   Available values C, S, L
    @data['bank_account_type'] = "W" # W - not available value
    assert.equal false, @transaction.setData(@data).isValid()

  it 'fails when missing beneficial parameter by using MYR currency ', ->
    delete @data['bank_account_type']

    @data['currency'] = "MYR"
    assert.equal false, @transaction.setData(@data).isValid()

  it 'works when beneficial parameter are set with using MYR currency ', ->
    @data['currency'] = "MYR"

    @data['beneficiary_bank_code'] = "TEST_BANK_CODE"
    @data['beneficiary_name'] = "TEST_NAME"
    @data['beneficiary_account_number'] = "TEST_ACCOUNT_NUMBER"

    assert.equal true, @transaction.setData(@data).isValid()

  it 'works when Travel data ', ->
    data = _.clone @data
    data = _.extend(data, {
      travel: {
        ticket: {
          credit_reason_indicator_1: "A",
          credit_reason_indicator_2: "B",
          ticket_change_indicator: "C"
        }
      }
    })

    assert.equal true, @transaction.setData(@data).isValid()



