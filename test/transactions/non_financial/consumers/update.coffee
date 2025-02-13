path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/non_financial/consumers/update'

describe 'Update Consumer request', ->

  beforeEach ->
    fakeData     = new FakeData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data = {
      consumer_id:      faker.datatype.number().toString()
      email:            'travis@email.com',
      billing_address:  fakeData.getBillingData().billing_address,
      shipping_address: fakeData.getShippingData().shipping_address
    }

  Base()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

    it 'works without billing and shipping parameters', ->
      data = _.clone(@data)
      delete data.billing_address
      delete data.shipping_address

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails without consumer_id parameter', ->
      data = _.clone(@data)
      delete data.consumer_id

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails without email parameter', ->
      data = _.clone(@data)
      delete data.email

      assert.equal false, @transaction.setData(data).isValid()
