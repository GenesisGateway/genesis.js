path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/processed_transactions/processed_transactions'

describe 'Processed Transactions request', ->

  beforeEach ->
    @data = {
      unique_id: faker.random.alphaNumeric()
    }
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works with unique_id parameter', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with arn parameter', ->
      data = _.clone(@data)
      delete data.unique_id
      data.arn = faker.random.alphaNumeric()
      assert.isTrue @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'fails with arn and unique_id parameters', ->
      data = _.clone(@data)
      data.arn = faker.random.alphaNumeric()
      assert.isNotTrue @transaction.setData(data).isValid()

  Base()
