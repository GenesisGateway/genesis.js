_                   = require 'underscore'
path                = require 'path'
faker               = require 'faker'
FakeConfig          = require '../../fake_config'
FakeData            = require '../../fake_data'
TokenizationExample = require '../../../examples/attributes/non-financial/tokenization'
Transaction         = require '../../../../src/genesis/transactions/non_financial/tokenization/get_tokenized_card'
Base                = require '../../base'

describe 'Get Tokenized Card request', ->
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
