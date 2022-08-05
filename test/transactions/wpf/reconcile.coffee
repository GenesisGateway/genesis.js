
path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData    = require '../fake_data'
Transaction = require path.resolve './src/genesis/transactions/wpf/reconcile'
Base        = require '../base'

describe 'WPFReconcile Transaction', ->

  before ->
    @data        = {
      'unique_id': faker.random.alphaNumeric()
    }
    @transaction = new Transaction()

  it 'fails when missing required unique_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'unique_id').isValid()

  Base()
