path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig    = require path.resolve './test/transactions/fake_config'
FakeData      = require '../../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/financial/vouchers/cashu'
FinancialBase = require '../financial_base'

describe 'CashU Transaction', ->

  beforeEach ->
    @data        = (new FakeData).getApmData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data['remote_ip']                  = faker.internet.ip()
    @data['return_success_url']         = faker.internet.url()
    @data['return_failure_url']         = faker.internet.url()
    @data['customer_email']             = faker.internet.email()
    @data['currency'] = faker.random.arrayElement([
      "USD", "AED", "EUR", "JOD", "EGP", "SAR", "DZD", "LBP", "MAD", "QAR", "TRY"
    ])
    @data['billing_address']['country'] = faker.random.arrayElement([
      "DZ", "BH", "EG", "GM", "GH", "IN", "IR", "IQ", "IL", "JO", "KE",
      "KR", "KW", "LB", "LY", "MY", "MR", "MA", "NG", "OM", "PK", "PS",
      "QA", "SA", "SL", "SD", "SY", "TZ", "TN", "TR", "AE", "US", "YE"
    ])

  FinancialBase()

  it 'works without remote_ip', ->
    data = _.clone @data
    delete data.remote_ip

    assert.equal true, @transaction.setData(data).isValid()

  it 'fails when wrong country parameter added', ->
    data = _.clone @data
    data['billing_address']['country'] = 'NOT_VALID_COUNTRY'

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing country parameter', ->
    data = _.clone @data
    delete data.billing_address.country

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong currency parameter added', ->
    data = _.clone @data
    data['currency'] = 'NOT_VALID_CURRENCY'

    assert.equal false, @transaction.setData(data).isValid()



  it 'works with existing currency', ->
    data = _.clone @data
    @data['currency'] = 'SAR'

    assert.equal true, @transaction.setData(data).isValid()

  it 'works with existing billing_address country', ->
    data = _.clone @data
    data['billing_address']['country'] = 'SL'

    assert.equal true, @transaction.setData(data).isValid()



