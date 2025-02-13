path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
ModeList    = require path.resolve './test/examples/attributes/non-financial/mode_list'
Transaction = require path.resolve './src/genesis/transactions/non_financial/fraud/retrieval/retrieval'

describe 'Retrieval Transaction', ->

  before ->
    @data = original_transaction_unique_id: faker.random.alphaNumeric()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'when invalid request', ->

    it 'fails when missing required parameter', ->
      data = _.clone @data
      delete data.original_transaction_unique_id
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails with several required parameters at once', ->
      data = _.clone @data
      data.arn = faker.random.alphaNumeric()
      assert.isNotTrue @transaction.setData(data).isValid()

  context 'when valid request', ->

    it 'works with original_transaction_unique_id parameter', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'works with arn parameter', ->
      data = _.clone @data
      delete data.original_transaction_unique_id
      data.arn = faker.random.alphaNumeric()
      assert.isTrue @transaction.setData(data).isValid()

  Base()
  ModeList()
