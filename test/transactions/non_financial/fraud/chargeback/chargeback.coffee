path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
ModeList    = require path.resolve './test/examples/attributes/non-financial/mode_list'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/fraud/chargeback/chargeback'

describe 'Chargeback Transaction', ->

  before ->
    @data = original_transaction_unique_id: faker.random.alphaNumeric()
    @data = arn: faker.random.alphaNumeric()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'with invalid request', ->

    it 'fails when missing required parameter', ->
      data = _.clone @data
      delete data.original_transaction_unique_id
      delete data.arn
      assert.isNotTrue @transaction.setData(data).isValid()

    it 'fails when wrong original_transaction_unique_id parameter added', ->
      data = _.clone @data
      data.original_transaction_unique_id = 100
      assert.isNotTrue @transaction.setData(data).isValid()

  context 'with valid request', ->

    it 'works with original_transaction_unique_id parameter', ->
      data = _.clone @data
      data.original_transaction_unique_id = faker.random.alphaNumeric()
      delete data.arn
      assert.isTrue @transaction.setData(data).isValid()

    it 'works with arn parameter', ->
      data = _.clone @data
      data.arn = faker.random.alphaNumeric()
      delete data.original_transaction_unique_id
      assert.isTrue @transaction.setData(data).isValid()

  Base()
  ModeList()
