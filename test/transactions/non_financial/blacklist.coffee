path  = require 'path'
_     = require 'underscore'

Base        = require '../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require path.resolve './src/genesis/transactions/non_financial/blacklist'

describe 'Blacklist Transaction', ->

  before ->
    @data        =
      card_number: '4200000000000000'

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'fails when missing required card_number parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'card_number').isValid()

  Base()
