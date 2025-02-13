path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../base'
FakeConfig  = require '../fake_config'
Transaction = require path.resolve './src/genesis/transactions/wpf/reconcile'

describe 'WPFReconcile Transaction', ->

  before ->
    @data        = {
      'unique_id': faker.random.alphaNumeric()
    }
    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'fails when missing required unique_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'unique_id').isValid()

  Base()
