path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require path.resolve './src/genesis/transactions/non_financial/reconcile/reconcile'

describe 'Reconcile Transaction', ->

  before ->
    @data =
      unique_id:      faker.random.alphaNumeric(),
      transaction_id: faker.random.alphaNumeric(),
      arn: faker.random.alphaNumeric()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'fails when missing required parameter', ->
    assert.equal false, @transaction.setData(
      _.omit @data, ['transaction_id', 'unique_id', 'arn']
    ).isValid()

  it 'works only with unique_id', ->
    assert.equal true, @transaction.setData(_.omit @data, 'transaction_id').isValid()

  it 'works only with transaction_id', ->
    assert.equal true, @transaction.setData(_.omit @data, 'unique_id').isValid()

  it 'works only with arn', ->
    assert.equal true, @transaction.setData(_.omit @data, 'arn').isValid()

  Base()
