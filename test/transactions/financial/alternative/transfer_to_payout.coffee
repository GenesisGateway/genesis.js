path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig  = require path.resolve './test/transactions/fake_config'
FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/alternative/transfer_to_payout'

FinancialExamples = require '../financial_base'

describe 'TransferTo Payout Transaction', ->

  before ->
    @id_type = [
      "PASSPORT", "NATIONAL_ID", "DRIVING_LICENSE", "SOCIAL_SECURITY", "TAX_ID", "SENIOR_CITIZEN_ID",
      "BIRTH_CERTIFICATE", "VILLAGE_ELDER_ID", "RESIDENT_CARD", "ALIEN_REGISTRATION", "PAN_CARD",
      "VOTERS_ID", "HEALTH_CARD", "EMPLOYER_ID", "OTHER"
    ]
    @country = 'USA'

  beforeEach ->
    @data        = (new FakeData).getMinimumData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['amount']             = 100
    @data['currency']           = 'EUR'
    @data['customer_email']     = faker.internet.email()
    @data['payer_id']           = faker.datatype.number().toString()

  context 'when valid request', ->

    it 'with required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'with all parameters', ->
      @data.bank_account_number                 = faker.datatype.number().toString()
      @data.indian_financial_system_code        = faker.datatype.number().toString()
      @data.msisdn                              = '12345678'
      @data.branch_number                       = faker.datatype.number().toString()
      @data.account_type                        = faker.random.arrayElement(
        ["CHECKING", "SAVINGS", "DEPOSIT", "OTHERS"]
      )
      @data.registered_name                     = faker.lorem.word()
      @data.registration_number                 = faker.datatype.number().toString()
      @data.document_reference_number           = faker.datatype.number().toString()
      @data.purpose_of_remittance               = faker.random.arrayElement([
        "FAMILY_SUPPORT", "EDUCATION", "GIFT_AND_DONATION", "MEDICAL_TREATMENT", "MAINTENANCE_EXPENSES",
        "TRAVEL", "SMALL_VALUE_REMITTANCE", "LIBERALIZED_REMITTANCE", "OTHER"
      ])
      @data.iban                                = faker.finance.iban()
      @data.id_type                             = faker.random.arrayElement(@id_type)
      @data.id_number                           = faker.datatype.number().toString()
      @data.sender_date_of_birth                = '1990-08-12'
      @data.sender_first_name                   = faker.name.firstName()
      @data.sender_country_iso_code             = @country
      @data.sender_id_number                    = faker.datatype.number().toString()
      @data.sender_nationality_country_iso_code = @country
      @data.sender_address                      = faker.address.streetAddress()
      @data.sender_occupation                   = faker.lorem.word()
      @data.sender_beneficiary_relationship     = faker.lorem.word()
      @data.sender_postal_code                  = faker.datatype.number().toString()
      @data.sender_city                         = faker.address.city()
      @data.sender_msisdn                       = '12345678'
      @data.sender_gender                       = faker.name.gender()
      @data.sender_id_type                      = faker.random.arrayElement(@id_type)
      @data.sender_province_state               = faker.address.state()
      @data.sender_source_of_funds              = faker.lorem.word()
      @data.sender_country_of_birth_iso_code    = @country
      @data.billing_address                     = (new FakeData).getBillingData().billing_address

      assert.isTrue @transaction.setData(@data).isValid()
  
  context 'when invalid request', ->

    it 'fails with missing required return_success_url parameter', ->
      delete @data.return_success_url
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required return_failure_url parameter', ->
      delete @data.return_failure_url
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required payer_id parameter', ->
      delete @data.payer_id
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with too short msisdn parameter', ->
      @data.msisdn = faker.random.alpha(5)
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with too long msisdn parameter', ->
      @data.msisdn = faker.random.alpha(33)
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with too short sender_msisdn parameter', ->
      @data.sender_msisdn = faker.random.alpha(5)
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with too long sender_msisdn parameter', ->
      @data.sender_msisdn = faker.random.alpha(33)
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid iban parameter', ->
      @data.iban = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid purpose_of_remittance parameter', ->
      @data.purpose_of_remittance = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid account_type parameter', ->
      @data.account_type = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid id_type parameter', ->
      @data.id_type = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid sender_id_type parameter', ->
      @data.sender_id_type = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid sender_date_of_birth parameter', ->
      @data.sender_date_of_birth = '30-12-1987'
      assert.isNotTrue @transaction.setData(@data).isValid()

  FinancialExamples()
