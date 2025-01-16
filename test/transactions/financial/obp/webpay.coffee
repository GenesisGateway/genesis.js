path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData            = require '../../fake_data'
Transaction         = require path.resolve './src/genesis/transactions/financial/obp/webpay'
AlternativeExamples = require '../alternative/alternative_base'

describe 'Webpay Transaction', ->

  beforeEach ->
    fakeData     = new FakeData()
    @transaction = new Transaction()
    @data        = fakeData.getApmData()
    delete @data.customer_phone

    @data.billing_address.country = 'CL'
    @data.return_success_url      = faker.internet.url()
    @data.return_failure_url      = faker.internet.url()
    @data.return_pending_url      = faker.internet.url()
    @data.consumer_reference      = 'Consumer Reference'
    @data.national_id             = '8812128812'
    @data.birth_date              = '30-12-1992'
    @data.shipping_address        = fakeData.getShippingData().shipping_address

  AlternativeExamples()

  context 'with valid request', ->

    it 'works when existing country code parameter added', ->
      data = _.clone @data
      data.billing_address.country = 'CL'

      assert.isTrue @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails when return_success_url missing', ->
      data = _.clone @data
      delete data.return_success_url

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when return_failure_url missing', ->
      data = _.clone @data
      delete data.return_failure_url

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when consumer_reference missing', ->
      data = _.clone @data
      delete data.consumer_reference

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when national_id missing', ->
      data = _.clone @data
      delete data.national_id

      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when not supported country parameter added', ->
      data = _.clone @data
      data.billing_address.country = 'AT'

      assert.isNotTrue @transaction.setData(data).isValid()
