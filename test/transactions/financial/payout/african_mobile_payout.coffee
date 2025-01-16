path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData           = require path.resolve './test/transactions/fake_data'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/payout/african_mobile_payout'
FinancialBase      = require path.resolve './test/transactions/financial/financial_base'

describe 'African Mobile Payout Transaction', ->

  beforeEach ->
    fakeData                      = new FakeData
    @data                         = fakeData.getSimpleData()
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.currency                = 'GHS'
    @data.amount                  = '10000'
    @data.operator                = "VODACOM"
    @data.target                  =  '000010'
    @data.billing_address         = fakeData.getBillingData().billing_address
    @data.billing_address.country = 'GH'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

    @transaction                  = new Transaction()

  FinancialBase()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with GH country, GHS currency, and AIRTEL, MTN, TIGO or VODACOM operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'GH'
      data.currency = 'GHS'
      data.operator = faker.random.arrayElement( ["AIRTEL", "MTN", "TIGO", "VODACOM"] )

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with KE country, KES currency, and AIRTEL or SAFARICOM operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'KE'
      data.currency = 'KES'
      data.operator = faker.random.arrayElement( ["AIRTEL", "SAFARICOM"] )

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with MZ country, MZN currency, and MOVITEL or VODACOM operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'MZ'
      data.currency = 'MZN'
      data.operator = faker.random.arrayElement(["MOVITEL", "VODACOM"])

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with RW country, RWF currency, and MTN or TIGO operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'RW'
      data.currency = 'RWF'
      data.operator = faker.random.arrayElement(["MTN", "TIGO"])

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with TZ country, TZS currency, and AIRTEL, TIGO or VODACOM operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'TZ'
      data.currency = 'TZS'
      data.operator = faker.random.arrayElement(["AIRTEL", "TIGO", "VODACOM"])

      assert.equal true, @transaction.setData(data).isValid()

    it 'works with UG country, UGX currency, and AIRTEL or MTN operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'UG'
      data.currency = 'UGX'
      data.operator = faker.random.arrayElement(["AIRTEL", "MTN"])

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails with invalid country code', ->
      data = _.clone(@data)
      data.billing_address.country = 'EU'
      data.currency = 'GHS'
      data.operator = 'VODACOM'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with valid country code, invalid currency code', ->
      data = _.clone(@data)
      data.billing_address.country = 'GH'
      data.currency = 'EUR'
      data.operator = 'VODACOM'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with valid country code, valid currency code, invalid operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'GH'
      data.currency = 'GHS'
      data.operator = 'INVALID_OPERATOR'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with KE country, KES currency, and invalid operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'KE'
      data.currency = 'KES'
      data.operator = 'MTN'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with MZ country, MZN currency, invalid operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'MZ'
      data.currency = 'MZN'
      data.operator = 'AIRTEL'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with RW country, RWF currency, invalid operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'RW'
      data.currency = 'RWF'
      data.operator = 'VODACOM'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with TZ country, TZS currency, and invalid operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'TZ'
      data.currency = 'TZS'
      data.operator = 'SAFARICOM'

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails with UG country, UGX currency, and invalid operator', ->
      data = _.clone(@data)
      data.billing_address.country = 'UG'
      data.currency = 'UGX'
      data.operator = 'TIGO'

      assert.equal false, @transaction.setData(data).isValid()
