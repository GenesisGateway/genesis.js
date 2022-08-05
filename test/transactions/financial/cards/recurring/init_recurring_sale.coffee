path  = require 'path'
_     = require 'underscore'

FakeData           = require '../../../fake_data'
CardBase           = require '../card_base'
BusinessAttributes = require '../../../business_attributes'
Transaction        =
  require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale'
Moto               = require '../../../../examples/attributes/financial/moto'


describe 'InitRecurringSale Transaction', ->

  before ->
    @data        = (new FakeData).getDataWithBusinessAttributes()
    @transaction = new Transaction()

  CardBase()
  BusinessAttributes()
  Moto()

