path  = require 'path'
_     = require 'underscore'

FakeData           = require '../../fake_data'
Transaction        = require path.resolve './src/genesis/transactions/financial/cards/payout'
CardBase           = require './card_base'
Moto               = require '../../../examples/attributes/financial/moto'
Gaming             = require '../../../examples/attributes/financial/gaming'
Crypto             = require '../../../examples/attributes/financial/crypto'
DynamicDescriptor  = require '../../../examples/attributes/financial/dynamic_descriptor'

describe 'Payout Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

  CardBase()
  Moto()
  Gaming()
  Crypto()
  DynamicDescriptor()
