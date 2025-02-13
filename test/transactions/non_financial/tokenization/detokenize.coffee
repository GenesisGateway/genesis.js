_                   = require 'underscore'
path                = require 'path'
faker               = require 'faker'
FakeConfig          = require '../../fake_config'
FakeData            = require '../../fake_data'
TokenizationExample = require '../../../examples/attributes/non-financial/tokenization'
Transaction         = require path.resolve './src/genesis/transactions/non_financial/tokenization/detokenize'
Base                = require '../../base'

describe 'Detokenize request', ->
  beforeEach ->
    fakeData    = new FakeData()
    @data       = fakeData.getTokenizationData()
    @data.token = faker.datatype.uuid()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)
      assert.isTrue @transaction.setData(data).isValid()

  TokenizationExample()
