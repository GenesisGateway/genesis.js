path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require path.resolve './test/transactions/fake_data'
Transaction   = require path.resolve (
  './src/genesis/transactions/financial/obp/online_banking/payout'
)
FinancialBase = require '../../financial_base'


describe 'Online Banking Payout Transaction', ->

  beforeEach ->
    @data                                 = (new FakeData).getSimpleData()
    @data.currency = faker.random.arrayElement(
      ["ARS", "BRL", "CAD", "CLP", "CNY", "COP", "IDR", "INR", "MYR", "MXN", "PEN", "THB", "UYU"]
    )
    @data.usage                           = '40208 concert tickets'
    @data.remote_ip                       = '245.253.2.12'
    @data.notification_url                = faker.internet.url()
    @data.return_success_url              = faker.internet.url()
    @data.return_failure_url              = faker.internet.url()
    @data.customer_email                  = 'travis@example.com'
    @data.customer_phone                  = '+1987987987987'
    @data.bank_name                       = 'Netbanking'
    @data.bank_code                       = '321'
    @data.bank_branch                     = 'HDFC0000001'
    @data.bank_account_name               = 'Anurak Nghuen'
    @data.bank_account_number             = '1234123412341234'
    @data.id_card_number                  = '123789456'
    @data.bank_account_type               =  faker.random.arrayElement(
      ["C", "S", "M", "P"]
    )
    @data.bank_account_verification_digit = '1'
    @data.document_type                   = 'PASS'
    @data.account_id                      = '11111111111111111111111'
    @data.user_id                         = '11111111111111111111111'
    @data.birth_date                      = '01-01-2021'
    @data.payment_type                    = faker.random.arrayElement(
      ["bank_to_bank", "pix", "bsb", "pay_id", "bank_to_bank_b2b", "pix_b2b", "clabe", "cellphone"]
    )
    @data.billing_address                 =  {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      neighborhood: 'Holywood',
      country: 'US'
    }
    @data.payer                           =  {
      document_id:                     faker.datatype.string(16),
      bank_code:                       faker.datatype.string(12),
      bank_account_number:             faker.datatype.string(33),
      bank_branch:                     faker.datatype.string(11),
      bank_account_verification_digit: '5',
      bank_phone_number:               '1234567890'
    }
    @data.company_type                    = ''
    @data.companyActivity                 = ''
    @data.incorporation_date              = '2021-01-01'
    @data.mothers_name                    = ''
    @data.pix_key                         = ''
    @data.document_id                     = '1234'
    @transaction                          = new Transaction(@data, FakeConfig.getConfig())

  FinancialBase()

  context 'with invalid request', ->

    it 'fails when wrong currency parameter added', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(['NOT_VALID_CURRENCY', 'USD'])

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with wrong bank_account_type', ->
      data = _.clone @data
      data['bank_account_type'] = 'NOT_VALID_BANK_ACCOUNT_TYPE'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with wrong payment_type', ->
      data = _.clone @data
      data['payment_type'] = 'NOT_VALID_PAYMENT_TYPE'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with out of range id_card_number length', ->
      data = _.clone @data
      data.id_card_number = faker.datatype.string(32)

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with out of range bank_account_verification_digit length', ->
      data = _.clone @data
      data.bank_account_verification_digit = faker.datatype.string(2)

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with out of range document_type length', ->
      data = _.clone @data
      data.document_type = faker.datatype.string(11)

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when BRL currency and missing bank_code and bank_name parameter', ->
      data = _.clone @data
      data['currency'] = 'BRL'
      delete data['bank_code']
      delete data['bank_name']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with aditional payer element', ->
      data = _.clone @data
      data.payer.element = 'invalid_value'
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with out of range payer document_id length', ->
      data = _.clone @data
      data.payer.document_id = faker.datatype.string(18)

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with out of range payer bank_code length', ->
      data = _.clone @data
      data.payer.bank_code = faker.datatype.string(13)

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with out of range payer bank_account_number length', ->
      data = _.clone @data
      data.payer.bank_account_number = faker.datatype.string(34)

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with out of range payer bank_branch length', ->
      data = _.clone @data
      data.payer.bank_branch = faker.datatype.string(12)

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with out of range payer bank_account_verification_digit length', ->
      data = _.clone @data
      data.payer.bank_account_verification_digit = faker.datatype.string(2)

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with out of range payer bank_phone_number length', ->
      data = _.clone @data
      data.payer.bank_phone_number = faker.datatype.string(12)

      assert.isNotTrue @transaction.setData(data).isValid()

  context 'with valid request', ->

    it 'works with allowed currency list', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(
        ["ARS", "BRL", "CAD", "CLP", "CNY", "COP", "IDR", "INR", "MYR", "MXN", "PEN", "THB", "UYU"]
      )

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with allowed bank_account_type', ->
      data = _.clone @data
      data['bank_account_type'] = faker.random.arrayElement(
        ["C", "S", "M", "P"]
      )

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with allowed payment_type', ->
      data = _.clone @data
      data['payment_type'] = faker.random.arrayElement(
        ["bank_to_bank", "pix", "bsb", "pay_id", "bank_to_bank_b2b", "pix_b2b", "clabe", "cellphone"]
      )

      assert.equal true, @transaction.setData(data).isValid()

    it 'works when BRL currency and bank_code and without bank_name parameters', ->
      data = _.clone @data
      data['currency'] = 'BRL'
      data['bank_code'] = '321'
      delete data['bank_name']

      assert.equal true, @transaction.setData(data).isValid()

    it 'works when BRL currency and bank_name and without bank_code parameters', ->
      data = _.clone @data
      data['currency'] = 'BRL'
      data['bank_name'] = '321'
      delete data['bank_code']

      assert.equal true, @transaction.setData(data).isValid()

    it 'works when allow empty bank_name with non-empty bank_code', ->
      data = _.clone @data
      data['currency'] = 'BRL'
      data['bank_code'] = '321'
      data['bank_name'] = ''

      assert.equal true, @transaction.setData(data).isValid()

    it 'works when any currency is set except BRL, and without bank_code and ', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(
        ["ARS", "CAD", "CLP", "CNY", "COP", "IDR", "INR", "MYR", "MXN", "PEN", "THB", "UYU"]
      )
      delete data['bank_code']
      delete data['bank_name']

      assert.equal true, @transaction.setData(data).isValid()
