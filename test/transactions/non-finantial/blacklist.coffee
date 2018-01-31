path  = require 'path'
_     = require 'underscore'

Transaction = require path.resolve './src/genesis/transactions/non_financial/blacklist'
Base        = require '../base'

describe 'Blacklist Transaction', ->

  before ->
    @data        =
      card_number: '4200000000000000'

    @transaction = new Transaction()

  it 'fails when missing required card_number parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'card_number').isValid()

  Base()
