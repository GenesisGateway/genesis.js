path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require '../../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/financial/vouchers/neosurf'
FinancialBase = require '../financial_base'

describe 'Neosurf Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['remote_ip']                  = faker.internet.ip()
    @data['return_success_url']         = faker.internet.url()
    @data['return_failure_url']         = faker.internet.url()
    @data['customer_email']             = faker.internet.email()
    @data['customer_phone']             = '+1987987987987'
    @data['voucher_number']             = faker.random.alphaNumeric(10)
    @data['currency']                   = faker.random.arrayElement([
      "AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "IDR",
      "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK",
      "SGD", "THB", "TRY", "USD", "XOF", "ZAR"
    ])
    @data['billing_address']['country'] = faker.random.arrayElement([
      "AT", "DZ", "AU", "BI", "BF", "BJ", "BE", "CV", "CY", "CA", "CF", "TD", "CO", "CG", "CM",
      "CD", "DK", "GQ", "FR", "GM", "DE", "GA", "GN", "GH", "GW", "HK", "IE", "IT", "CI", "KE",
      "LU", "MW", "MZ", "MA", "MR", "ML", "NE", "NG", "NL", "NZ", "NO", "PL", "PT", "RW", "RU",
      "RO", "SE", "ES", "SL", "SN", "ST", "CH", "RS", "TR", "TG", "TN", "GB", "TZ", "UG", "ZW",
      "ZM"
    ])

  FinancialBase()

  context 'when invalid request', ->

    it 'fails with invalid country parameter', ->
      data = _.clone @data
      data['billing_address']['country'] = 'INVALID'

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with missing country parameter', ->
      data = _.clone @data
      delete data.billing_address.country

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with invalid currency parameter', ->
      data = _.clone @data
      data['currency'] = 'INVALID'

      assert.isNotTrue @transaction.setData(data).isValid()
  
    it 'fails with missing country parameter', ->
      data = _.clone @data
      delete data.currency

      assert.isNotTrue @transaction.setData(data).isValid()
    
    it 'fails with invalid voucher_number', ->
      data = _.clone @data
      data['voucher_number'] = faker.random.alphaNumeric(11)

      assert.isNotTrue @transaction.setData(data).isValid()

  context 'when valid request', ->

    it 'works with valid currency', ->
      data = _.clone @data
      @data['currency'] = 'EUR'

      assert.isTrue @transaction.setData(data).isValid()

    it 'works with valid billing_country', ->
      data = _.clone @data
      data['billing_address']['country'] = 'AT'

      assert.isTrue @transaction.setData(data).isValid()

    it 'works with valid voucher_number', ->
      assert.isTrue @transaction.setData(@data).isValid()

