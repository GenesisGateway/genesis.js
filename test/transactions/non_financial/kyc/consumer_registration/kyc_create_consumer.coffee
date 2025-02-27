path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/consumer_registration/kyc_create_consumer'

describe 'KYC Create Consumer Request', ->

  beforeEach ->
    @data = {
      customer_unique_id:               faker.datatype.number().toString()
      customer_registration_date:       '2024-05-27'
      customer_registration_ip_address: faker.internet.ip()
      customer_information: {
        first_name:     faker.name.firstName(),
        last_name:      faker.name.lastName(),
        customer_email: faker.internet.email(),
        address1:       faker.address.streetAddress(),
        city:           faker.address.city(),
        province:       faker.address.city(),
        zip_code:       faker.address.zipCode(),
        country:        faker.address.countryCode()
      }
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'with json builder interface', ->
    assert.equal @transaction.builderInterface, 'json'

  it 'fails when missing required parameters', ->
    data = _.clone @data
    delete data.customer_unique_id
    delete data.customer_registration_date
    delete data.customer_registration_ip_address
    delete data.customer_information
    data.session_id = faker.random.alphaNumeric()
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'works with all required parameters', ->
    assert.isTrue @transaction.setData(@data).isValid()

  it 'works with all parameters', ->
    data = _.clone @data
    data.session_id =                           faker.random.alphaNumeric()
    data.customer_information.middle_name =     faker.name.firstName()
    data.customer_information.address2 =        faker.address.streetAddress()
    data.customer_information.phone1 =          faker.phone.phoneNumber()
    data.customer_information.phone2 =          faker.phone.phoneNumber()
    data.customer_information.birth_date =      '2000-01-01'
    data.customer_information.document_type =   faker.random.arrayElement(
      [0, 1, 2, 3, 4, 8, 12, 13, 16, 17, 18]
    )
    data.customer_information.document_number = faker.random.alphaNumeric()
    data.customer_information.gender =          faker.random.arrayElement( ["F", "M"])
    data.customer_username =                    faker.internet.userName()
    data.customer_registration_device_id =      faker.datatype.number().toString()
    data.third_party_device_id =                faker.datatype.number().toString()
    data.device_fingerprint =                   faker.random.alphaNumeric()
    data.device_fingerprint_type =              faker.random.arrayElement( [1, 2, 3])
    data.profile_action_type =                  1
    data.profile_current_status =               faker.random.arrayElement( [0, 1, 2, 3])
    data.bonus_code =                           faker.random.alpha()
    data.bonus_submission_date =                '2024-01-01'
    data.bonus_amount =                         faker.datatype.number()
    data.merchant_website =                     faker.internet.url()
    data.industry_type =                        faker.random.arrayElement( [1, 2, 3, 4, 5, 6, 7, 8, 9])
    data.how_did_you_hear =                     faker.random.alpha()
    data.affiliate_id =                         faker.random.alphaNumeric()
    data.rule_context =                         1
    assert.isTrue @transaction.setData(data).isValid()

  it 'fails with invalid document_type parameter', ->
    data = _.clone @data
    data.customer_information.document_type = 'invalid_value'
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'fails with invalid device_fingerprint_type parameter', ->
    data = _.clone @data
    data.device_fingerprint_type = 'invalid_value'
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'fails with invalid profile_current_status parameter', ->
    data = _.clone @data
    data.profile_current_status = 'invalid_value'
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'fails with invalid industry_type parameter', ->
    data = _.clone @data
    data.industry_type = 'invalid_value'
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'fails with invalid gender parameter', ->
    data = _.clone @data
    data.customer_information.gender = 'invalid_value'
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'fails with empty consumer_information parameter', ->
    data = _.clone @data
    delete data.customer_information
    assert.isNotTrue @transaction.setData(data).isValid()

  Base()
