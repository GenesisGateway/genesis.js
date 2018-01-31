path  = require 'path'
_     = require 'underscore'

FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/authorize'
CardBase    = require './card_base'

describe 'Authorize Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

  CardBase()