path  = require 'path'
faker = require 'faker'

Base        = require '../../../base'
Currency    = require path.resolve './src/genesis/helpers/currency'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/transaction/kyc_create_transaction'

describe 'KYC Create Transaction Request', ->

  beforeEach ->
    @data = {
      customer_information: {
        first_name:           faker.name.firstName(),
        last_name:            faker.name.lastName(),
        customer_email:       faker.internet.email(),
        address1:             faker.address.streetAddress(),
        city:                 faker.address.city(),
        province:             faker.address.city(),
        zip_code:             faker.address.zipCode(),
        country:              faker.address.countryCode()
      }
      deposit_limits: {
        payment_method:       "CC"
      }
      transaction_unique_id:  faker.datatype.number().toString()
      transaction_created_at: '2024-05-27 00:00:00'
      customer_ip_address:    faker.internet.ip()
      payment_details: {
        bin:                  '123456'
        tail:                 '1234'
        hashed_pan:           faker.random.alphaNumeric()
      }
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'when invalid request', ->
    it 'fails with missing required deposit_limits parameter', ->
      delete @data.deposit_limits
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required transaction_unique_id parameter', ->
      delete @data.transaction_unique_id
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required transaction_created_at parameter', ->
      delete @data.transaction_created_at
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing required payment_details parameter', ->
      delete @data.payment_details
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid format of transaction_created_at parameter', ->
      @data.transaction_created_at = "25-12-2024 12:30"
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid payment_method parameter', ->
      @data.deposit_limits.payment_method = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with missing EC payment_method required parameters', ->
      @data.deposit_limits.payment_method = 'EC'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid device_fingerprint_type parameter', ->
      @data.device_fingerprint_type = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid industry_type parameter', ->
      @data.industry_type = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid document_type parameter', ->
      @data.customer_information.document_type = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid gender parameter', ->
      @data.customer_information.gender = 'invalid_value'
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with empty consumer_information parameter', ->
      delete @data.customer_information
      assert.isNotTrue @transaction.setData(@data).isValid()

  context 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/create_transaction'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with EC payment_method required parameters', ->
      @data.deposit_limits.payment_method = 'EC'
      @data.payment_details.routing = faker.datatype.number().toString()
      @data.payment_details.account = faker.random.alpha()
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with all parameters', ->
      @data.session_id =                           faker.random.alphaNumeric()
      @data.customer_username =                    faker.internet.userName()
      @data.customer_unique_id =                   faker.random.alphaNumeric()
      @data.customer_status =                      faker.random.alpha()
      @data.customer_loyalty_level =               faker.random.alpha()
      @data.customer_registration_date =           '2024-01-01'
      @data.customer_registration_ip_address =     faker.internet.ip()
      @data.customer_registration_device_id =      faker.datatype.number().toString()

      @data.customer_information.middle_name =     faker.name.firstName()
      @data.customer_information.address2 =        faker.address.streetAddress()
      @data.customer_information.phone1 =          faker.phone.phoneNumber()
      @data.customer_information.phone2 =          faker.phone.phoneNumber()
      @data.customer_information.birth_date =      '2000-01-01'
      @data.customer_information.document_type =   faker.random.arrayElement(
        [0, 1, 2, 3, 4, 8, 12, 13, 16, 17, 18]
      )
      @data.customer_information.document_number = faker.random.alphaNumeric()
      @data.customer_information.gender =          faker.random.arrayElement( ["F", "M"])

      @data.first_deposit_date =                   '2024-01-01'
      @data.first_withdrawal_date =                '2024-05-01'
      @data.deposits_count =                       faker.datatype.number()
      @data.withdrawals_count =                    faker.datatype.number()
      @data.current_balance =                      faker.datatype.number()

      @data.deposit_limits.minimum =               faker.datatype.number()
      @data.deposit_limits.daily_maximum =         faker.datatype.number()
      @data.deposit_limits.weekly_maximum =        faker.datatype.number()
      @data.deposit_limits.monthly_maximum =       faker.datatype.number()

      @data.billing_information =                  {}
      @data.billing_information.first_name =       faker.name.firstName()
      @data.billing_information.last_name =        faker.name.lastName()
      @data.billing_information.customer_email =   faker.internet.email()
      @data.billing_information.address1 =         faker.address.streetAddress()
      @data.billing_information.address2 =         faker.address.streetAddress()
      @data.billing_information.city =             faker.address.city()
      @data.billing_information.province =         faker.address.city()
      @data.billing_information.zip_code =         faker.address.zipCode()
      @data.billing_information.country =          faker.address.countryCode()
      @data.billing_information.phone1 =           faker.phone.phoneNumber()
      @data.billing_information.birth_date =       '2000-01-01'
      @data.billing_information.gender =           faker.random.arrayElement( ["F", "M"])

      @data.shipping_information =                 {}
      @data.shipping_information.first_name =      faker.name.firstName()
      @data.shipping_information.last_name =       faker.name.lastName()
      @data.shipping_information.customer_email =  faker.internet.email()
      @data.shipping_information.address1 =        faker.address.streetAddress()
      @data.shipping_information.address2 =        faker.address.streetAddress()
      @data.shipping_information.city =            faker.address.city()
      @data.shipping_information.province =        faker.address.city()
      @data.shipping_information.zip_code =        faker.address.zipCode()
      @data.shipping_information.country =         faker.address.countryCode()
      @data.shipping_information.phone1 =          faker.phone.phoneNumber()

      @data.payment_details.cvv_present =          faker.random.alpha()
      @data.payment_details.routing =              faker.datatype.number().toString()
      @data.payment_details.ewallet_id =           faker.random.alphaNumeric()

      @data.amount =                               1000
      @data.currency =                             faker.random.arrayElement (new Currency).getCurrencies()
      @data.transaction_status =                   faker.random.arrayElement(
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
      )
      @data.third_party_device_id =                faker.datatype.number().toString()
      @data.device_fingerprint =                   faker.random.alphaNumeric()
      @data.device_fingerprint_type =              faker.random.arrayElement( [1, 2, 3])
      @data.shopping_cart_items_count =            faker.datatype.number()
      @data.local_time =                           '2025-02-26 17:42:38'
      @data.order_source =                         faker.random.arrayElement( ["internet", "mobile", "inhouse"])
      @data.merchant_website =                     faker.internet.url()
      @data.industry_type =                        faker.random.arrayElement( [1, 2, 3, 4, 5, 6, 7, 8, 9])
      @data.customer_password =                    faker.random.alphaNumeric()
      @data.rule_context =                         1
      @data.custom_variable =                      faker.random.alpha()

      assert.isTrue @transaction.setData(@data).isValid()
