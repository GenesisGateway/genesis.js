path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require path.resolve './src/genesis/transactions/non_financial/consumers/retrieve'

describe 'Retrieve Consumer request', ->

  beforeEach ->
    @data = {
      consumer_id: faker.datatype.number().toString()
      email:       'travis@email.com'
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'with valid request', ->
    it 'works with both parameters', ->
      data = _.clone(@data)

      assert.isTrue @transaction.setData(data).isValid()

    it 'works without consumer_id parameter', ->
      data = _.clone(@data)
      delete data.consumer_id

      assert.isTrue @transaction.setData(data).isValid()

    it 'works without email parameter', ->
      data = _.clone(@data)
      delete data.email

      assert.isTrue @transaction.setData(data).isValid()

  context 'with invalid request', ->
    it 'fails without parameters', ->
      assert.isNotTrue @transaction.setData({}).isValid()
