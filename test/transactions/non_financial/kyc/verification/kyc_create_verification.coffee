path  = require 'path'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/verification/kyc_create_verification'

describe 'KYC Create Verification Request', ->

  beforeEach ->
    @data = {
      email:                           faker.internet.email()
      country:                         faker.address.countryCode()
      language:                        faker.random.arrayElement([
        "AF", "SQ", "AM", "AR", "HY", "AZ", "EU", "BE", "BN", "BS", "BG", "MY", "CA", "NY", "ZH", "CO",
        "HR", "CS", "DA", "NL", "EN", "EO", "ET", "TL", "FI", "FR", "FY", "GL", "KA", "DE", "EL", "GU",
        "HT", "HA", "HE", "HI", "HU", "ID", "GA", "IG", "IS", "IT", "JA", "JV", "KN", "KK", "KM", "KY",
        "KO", "KU", "LA", "LB", "LO", "LT", "LV", "MK", "MG", "MS", "ML", "MT", "MI", "MR", "MN", "NE",
        "NO", "PA", "FA", "PL", "PS", "PT", "RO", "RU", "SD", "SM", "SR", "GD", "SN", "SI", "SK", "SL",
        "SO", "ST", "ES", "SU", "SW", "SV", "TA", "TE", "TG", "TH", "TR", "UK", "UR", "UZ", "VI", "CY",
        "XH", "YI", "YO", "ZU"
      ])
      redirect_url:                    faker.internet.url()
      reference_id:                    faker.random.alphaNumeric()
      document_supported_types:        faker.random.arrayElements(
        [ "passport", "id_card", "driving_license", "credit_or_debit_card" ],
        2
      )
      address_supported_types:         faker.random.arrayElements(
        [
          "id_card", "passport", "driving_license", "utility_bill", "bank_statement", "rent_agreement",
          "employer_letter", "insurance_agreement", "tax_bill", "envelope", "cpr_smart_card_reader_copy"
        ],
        2
      )
      face: {
        allow_offline:                 faker.datatype.boolean()
        allow_online:                  faker.datatype.boolean()
        check_duplicate_request:       faker.datatype.boolean()
      }
      backside_proof_required:         faker.datatype.boolean()
      address_backside_proof_required: faker.datatype.boolean()
      expiry_date:                     '2024-01-01'
      allow_retry:                     faker.datatype.boolean()
      verification_mode:               faker.random.arrayElement(
        [ "any", "image_only", "video_only" ]
      )
      background_checks: {
        first_name:                    faker.name.firstName()
        middle_name:                   faker.name.firstName()
        last_name:                     faker.name.lastName()
        full_name:                     faker.name.findName()
        date_of_birth:                 "2000-12-31"
        async_update:                  faker.datatype.boolean()
        filters:                       faker.random.arrayElements(
            [
              "sanction", "warning", "fitness-probity", "pep", "pep-class-1", "pep-class-2", "pep-class-3",
              "pep-class-4", "adverse-media", "adverse-media-general", "adverse-media-narcotics",
              "adverse-media-fraud", "adverse-media-terrorism", "adverse-media-sexual-crime",
              "adverse-media-violent-crime", "adverse-media-financial-crime", "adverse-media-v2-other-minor",
              "adverse-media-v2-other-serious", "adverse-media-v2-other-financial",
              "adverse-media-v2-violence-non-aml-cft", "adverse-media-v2-financial-difficulty",
              "adverse-media-v2-regulatory", "adverse-media-v2-general-aml-cft", "adverse-media-v2-cybercrime",
              "adverse-media-v2-terrorism", "adverse-media-v2-violence-aml-cft", "adverse-media-v2-narcotics-aml-cft",
              "adverse-media-v2-fraud-linked", "adverse-media-v2-financial-aml-cft", "adverse-media-v2-property"
            ],
            2
        )
        match_score:                   100
      }
      document: {
        first_name:                    faker.name.firstName()
        last_name:                     faker.name.lastName()
        full_name:                     faker.name.findName()
        date_of_birth:                 "2000-12-31"
        allow_offline:                 faker.datatype.boolean()
        allow_online:                  faker.datatype.boolean()
      }
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'when invalid request', ->
    it 'fails with missing required parameter', ->
      delete @data.email
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with additional face element', ->
      @data.face.element = "invalid_value"
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with additional background_checks element', ->
      @data.background_checks.element = "invalid_value"
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with additional document element', ->
      @data.document.element = "invalid_value"
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid filter parameter value', ->
      @data.filter = "invalid_value"
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid document_supported_types parameter value', ->
      @data.document_supported_types = "invalid_value"
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid address_supported_types parameter value', ->
      @data.address_supported_types = "invalid_value"
      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'fails with invalid verification_mode parameter value', ->
      @data.verification_mode = "invalid_value"
      assert.isNotTrue @transaction.setData(@data).isValid()

  context 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint url', ->
      assert.equal @transaction.getUrl().path, 'api/v1/verifications'

    it 'with json builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

    it 'works with all required parameters', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with empty expiry_date parameter', ->
      @data.expiry_date = ''
      assert.isTrue @transaction.setData(@data).isValid()
