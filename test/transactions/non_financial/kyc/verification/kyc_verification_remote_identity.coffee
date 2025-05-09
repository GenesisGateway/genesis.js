faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require '../../../fake_config'
Transaction =
  require '../../../../../src/genesis/transactions/non_financial/kyc/verification/kyc_verification_remote_identity'

describe 'KYC Verification Remote Identity Request', ->

  beforeEach ->
    @data =
      email:                   faker.internet.email()
      reference_id:            faker.random.alpha(6)
      country:                 faker.address.countryCode('alpha-2')
      backside_proof_required: true
      expiry_date:             '2030-01-01',
      document_supported_types: [
        faker.random.arrayElement(["passport", "id_card", "driving_license", "credit_or_debit_card"])
      ]
      document:
        proof:         faker.random.alpha(1000)
        date_of_birth: "2000-12-31"
        first_name:    faker.name.firstName('male')
        middle_name:   faker.name.middleName('male')
        last_name:     faker.name.lastName('male')
        full_address:  faker.address.streetAddress(true)

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'when invalid request', ->
    it 'without required parameters', ->
      delete @data.email
      delete @data.reference_id

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid email', ->
      @data.email = faker.random.alpha(15)

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid country', ->
      @data.country = faker.random.alpha(2)

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid backside proof required', ->
      @data.backside_proof_required = 'true'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with document node with additional property', ->
      @data.document.field = 'value'

      assert.isNotTrue @transaction.setData(@data).isValid()

  context 'when valid request', ->
    it 'with build request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/verifications'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'without reference_id', ->
      delete @data.reference_id

      assert.isTrue @transaction.setData(@data).isValid()

    it 'without email', ->
      delete @data.email

      assert.isTrue @transaction.setData(@data).isValid()

    it 'without expiry_date parameter', ->
      @data.expiry_date = ''
      assert.isTrue @transaction.setData(@data).isValid()

    it 'without document node', ->
      delete @data.document

      assert.isTrue @transaction.setData(@data).isValid()
