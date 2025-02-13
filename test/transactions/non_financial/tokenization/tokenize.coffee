_                   = require 'underscore'
path                = require 'path'
faker               = require 'faker'
FakeConfig          = require '../../fake_config'
FakeData            = require '../../fake_data'
TokenizationExample = require '../../../examples/attributes/non-financial/tokenization'
CardDataExample     = require '../../../examples/attributes/non-financial/tokenization_card_data'
Transaction         = require path.resolve './src/genesis/transactions/non_financial/tokenization/tokenize'
Base                = require '../../base'

describe 'Tokenize request', ->
  beforeEach ->
    fakeData        = new FakeData()
    @data           = fakeData.getTokenizationData()
    @data.card_data = fakeData.getCCData()
    delete @data.card_data.cvv

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'with valid request', ->
    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.isTrue @transaction.setData(data).isValid()

  TokenizationExample()
  CardDataExample()
