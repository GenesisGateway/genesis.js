path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig            = require path.resolve './test/transactions/fake_config'
FakeData              = require '../fake_data'
FinancialBase         = require './financial_base'
Transaction           = require path.resolve './src/genesis/transactions/financial/refund'
InstallmentAttributes = require '../../examples/attributes/financial/installment_attributes'

describe 'Refund Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getSimpleData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  FinancialBase()
  InstallmentAttributes()

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

  describe 'Level 3 Travel attributes', ->
    beforeEach ->
      @travelData = _.extend(
        _.clone(@data),
        travel:
          ticket:
            credit_reason_indicator_1: "A"
            credit_reason_indicator_2: "B"
            ticket_change_indicator: "C"
      )

    it 'with travel attributes', ->
      assert.isNotTrue @transaction.setData(@travelData).isValid()

    it 'when travel node with additional properties', ->
      @travelData.travel.element = 'value'

      assert.isNotTrue @transaction.setData(@travelData).isValid()

    it 'when travel ticket node with additional properties', ->
      @travelData.travel.ticket.element = 'value'

      assert.isNotTrue @transaction.setData(@travelData).isValid()

    it 'when credit_reason_indicator_1 with invalid value', ->
      @travelData.travel.ticket.credit_reason_indicator_1 = 'C'

      assert.isNotTrue @transaction.setData(@travelData).isValid()

    it 'when credit_reason_indicator_2 with invalid value', ->
      @travelData.travel.ticket.credit_reason_indicator_2 = 'C'

      assert.isNotTrue @transaction.setData(@travelData).isValid()

    it 'when ticket_change_indicator with invalid value', ->
      @travelData.travel.ticket.ticket_change_indicator = 'A'

      assert.isNotTrue @transaction.setData(@travelData).isValid()



