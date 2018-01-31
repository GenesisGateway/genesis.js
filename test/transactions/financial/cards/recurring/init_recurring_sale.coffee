path  = require 'path'
_     = require 'underscore'

FakeData    = require '../../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale'
CardBase     = require '../card_base'

describe 'InitRecurringSale Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

  CardBase()
