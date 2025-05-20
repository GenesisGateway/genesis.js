faker             = require 'faker'
path              = require 'path'
_                 = require 'underscore'
Country           = require path.resolve './src/genesis/helpers/country'
Currency          = require path.resolve './src/genesis/helpers/currency'
FakeConfig        = require path.resolve './test/transactions/fake_config'
FakeData          = require '../../fake_data'
FinancialExamples = require '../financial_base'
Transaction       = require path.resolve './src/genesis/transactions/financial/crypto/bitpay_sale'

describe 'BitPay Sale Transaction', ->

  before ->
    @allowed_currencies = [
      "AFN", "ALL", "AOA", "ARS", "AMD", "AWG", "AUD", "AZN", "BSD", "BHD", "BBD", "BYN", "BZD", "BMD",
      "BTN", "BAM", "BWP", "BRL", "GBP", "BND", "BGN", "BIF", "XOF", "XAF", "XPF", "CAD", "CVE", "XCG",
      "KYD", "CLP", "CNY", "COP", "KMF", "CDF", "CRC", "CUP", "CZK", "DKK", "DJF", "DOP", "XCD", "ERN",
      "ETB", "FKP", "FJD", "GMD", "GEL", "GHS", "GIP", "GTQ", "GNF", "GYD", "HTG", "HNL", "HKD", "HUF",
      "ISK", "INR", "IRR", "ILS", "JMD", "JPY", "JOD", "KZT", "KES", "KPW", "KWD", "LAK", "LBP", "LSL",
      "LRD", "LYD", "MOP", "MGA", "MWK", "MYR", "MVR", "MRU", "MUR", "MXN", "MDL", "MNT", "MZN", "MMK",
      "NAD", "TWD", "NZD", "NIO", "NGN", "NOK", "OMR", "PAB", "PGK", "PYG", "PEN", "PHP", "PLN", "QAR",
      "RON", "RUB", "RWF", "SHP", "SVC", "WST", "SAR", "RSD", "SCR", "SLL", "SGD", "SBD", "SOS", "ZAR",
      "KRW", "SSP", "LKR", "SDG", "SRD", "SZL", "SEK", "CHF", "SYP", "STN", "TJS", "TZS", "THB", "TOP",
      "TTD", "TND", "TMT", "UGX", "UAH", "AED", "UYU", "UZS", "VUV", "YER", "ZMW"
    ]
    @allowed_countries = [
      "AF", "AX", "AL", "AS", "AD", "AO", "AI", "AQ", "AG", "AR", "AM", "AW", "AU", "AT", "AZ", "BS", "BH",
      "BB", "BY", "BE", "BZ", "BJ", "BM", "BT", "BQ", "BA", "BW", "BV", "BR", "IO", "BN", "BG", "BF", "BI",
      "CM", "CA", "CV", "KY", "CF", "TD", "CL", "CN", "CX", "CC", "CO", "KM", "CG", "CD", "CK", "CR", "CI",
      "HR", "CU", "CW", "CY", "CZ", "DK", "DJ", "DM", "DO", "SV", "GQ", "ER", "EE", "ET", "FK", "FO", "FJ",
      "FI", "FR", "GF", "PF", "TF", "GA", "GM", "GE", "DE", "GH", "GI", "GR", "GL", "GD", "GP", "GU", "GT",
      "GG", "GN", "GW", "GY", "HT", "HM", "VA", "HN", "HK", "HU", "IS", "IN", "IR", "IE", "IM", "IL", "IT",
      "JM", "JP", "JE", "JO", "KZ", "KE", "KI", "KP", "KR", "XK", "KW", "LA", "LV", "LB", "LS", "LR", "LY",
      "LI", "LT", "LU", "MO", "MG", "MW", "MY", "MV", "ML", "MT", "MH", "MQ", "MR", "MU", "YT", "MX", "FM",
      "MD", "MC", "MN", "ME", "MS", "MZ", "MM", "NA", "NR", "NL", "AN", "NC", "NZ", "NI", "NE", "NG", "NU",
      "NF", "MP", "NO", "OM", "PW", "PA", "PG", "PY", "PE", "PH", "PN", "PL", "PT", "PR", "QA", "RE", "RO",
      "RU", "RW", "BL", "SH", "KN", "LC", "MF", "PM", "VC", "WS", "SM", "ST", "SA", "SN", "RS", "SC", "SL",
      "SG", "SX", "SK", "SI", "SB", "SO", "ZA", "GS", "SS", "ES", "LK", "SD", "SR", "SJ", "SZ", "SE", "CH",
      "SY", "TW", "TJ", "TZ", "TH", "TL", "TG", "TK", "TO", "TT", "TN", "TM", "TC", "TV", "UG", "UA", "AE",
      "GB", "US", "UM", "UY", "UZ", "VU", "VE", "VG", "VI", "WF", "EH", "YE", "ZM", "ZW"
    ]

  beforeEach ->
    fakeData     = new FakeData()
    
    @data                         = fakeData.getMinimumData()
    @data.currency                = 'BGN'
    @data.amount                  = '100'
    @data.customer_email          = faker.internet.email()
    @data.return_url              = faker.internet.url()
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'BG'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works with all parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

  context 'with invalid request', ->

    it 'fails with invalid country code', ->
      @data.billing_address.country = faker.random.arrayElement(
        _.difference( (new Country).getCountries(), @allowed_countries)
      )

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid currency code', ->
      @data.currency = faker.random.arrayElement(
        _.difference( (new Currency).getCurrencies(), @allowed_currencies)
      )

      assert.isNotTrue @transaction.setData(@data).isValid()
    
    it 'fails with missing return_url parameter', ->
      delete @data.return_url

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid return_url parameter', ->
      @data.return_url = 'INVALID_VALUE'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing customer_email parameter', ->
      delete @data.customer_email

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid customer_email parameter', ->
      @data.customer_email = 'INVALID_VALUE'

      assert.isNotTrue @transaction.setData(@data).isValid()

  FinancialExamples()
