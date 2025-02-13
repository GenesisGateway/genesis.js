path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require path.resolve './src/genesis/transactions/non_financial/consumers/get_cards'
Base        = require path.resolve './test/transactions/base'

describe 'Get Consumer Cards request', ->

  beforeEach ->
    @data = {
      consumer_id: faker.random.alpha(10)
      email: faker.internet.email()
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

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
