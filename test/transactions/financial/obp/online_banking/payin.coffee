path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require '../../../fake_data'
Transaction        = require path.resolve (
  './src/genesis/transactions/financial/obp/online_banking/payin'
)

describe 'Online Banking Payin Transaction', ->

  beforeEach ->
    @data                         = (new FakeData).getSimpleData()
    @data.usage                   = '40208 concert tickets'
    @data.remote_ip               = faker.internet.ip()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.currency                = faker.random.arrayElement(
      ["CNY", "CLP", "THB", "MYR", "PYG", "IDR", "INR", "PHP", "SGD", "UYU", "VND",
        "PEN", "EUR", "USD", "MXN", "BRL", "CHF", "CAD", "PLN", "AUD", "NZD"]
    )
    @data.amount                  = '50000'
    @data.customer_email          = faker.internet.email()
    @data.customer_phone          = '+1987987987987'
    @data.bank_code               = 'BLK'
    @data.virtual_payment_address = 'someone@bank'
    @data.consumer_reference      = 'Consumer Reference'
    @data.user_category           = 'default'
    @data.payment_type            = faker.random.arrayElement(
      ["online_banking", "qr_payment", "quick_payment", "netbanking", "alipay_qr", "scotiabank"]
    )
    @data.auth_code               = '123456'
    @data.billing_address         = {
      first_name: 'John',
      last_name: 'Doe',
      address1: '123 Str.',
      zip_code: '10000',
      city: 'New York',
      country: 'US'
    }
    @transaction                  = new Transaction()

  context 'with invalid request', ->

    it 'fails when wrong currency parameter added', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement(['NOT_VALID_CURRENCY'])

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with wrong payment_type', ->
      data = _.clone @data
      data['payment_type'] = 'NOT_VALID_PAYMENT_TYPE'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with out of range auth_code length', ->
      data = _.clone @data
      data.auth_code = faker.datatype.string(7)

      assert.equal false, @transaction.setData(data).isValid()

  context 'with valid request', ->

    it 'works with allowed currency list and bank_code different from BLK', ->
      data = _.clone @data
      data['currency'] = faker.random.arrayElement([
        "CNY", "CLP", "THB", "MYR", "PYG", "IDR", "INR", "PHP", "SGD", "UYU", "VND",
          "PEN", "EUR", "USD", "MXN", "BRL", "CHF", "CAD", "PLN"
        ])
      data.bank_code = '000'

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with allowed payment_type', ->
      data = _.clone @data
      data['payment_type'] = faker.random.arrayElement(
        ["online_banking", "qr_payment", "quick_payment", "netbanking", "alipay_qr"]
      )
      data.currency = 'PLN'
      assert.equal true, @transaction.setData(data).isValid()

    it 'works with BLK bank_code, PLN currency and auth_code', ->
      data = _.clone @data
      data.bank_code = 'BLK'
      data.currency = 'PLN'
      data.auth_code = '111111'

      assert.equal true, @transaction.setData(data).isValid()

    it 'works PLN currency without BLK bank_code and auth_code', ->
      data = _.clone @data
      data.bank_code = '000'
      data.currency = 'PLN'

      assert.equal true, @transaction.setData(data).isValid()
