path  = require 'path'
_     = require 'underscore'

FakeData           = require '../../fake_data'
Transaction        = require path.resolve './src/genesis/transactions/financial/cards/sale'
CardBase           = require './card_base'
BusinessAttributes = require '../../business_attributes'
ScaParams          = require '../../../examples/attributes/sca_params'
Moto               = require '../../../examples/attributes/financial/moto'
Gaming             = require '../../../examples/attributes/financial/gaming'
Crypto             = require '../../../examples/attributes/financial/crypto'

describe 'Sale Transaction', ->

  before ->
    @data        = (new FakeData).getDataWithBusinessAttributes()
    @transaction = new Transaction()

  CardBase()
  BusinessAttributes()
  ScaParams()
  Moto()
  Gaming()
  Crypto()
