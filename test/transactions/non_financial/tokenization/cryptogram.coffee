_                   = require 'underscore'
path                = require 'path'
faker               = require 'faker'
FakeConfig          = require '../../fake_config'
FakeData            = require '../../fake_data'
TokenizationExample = require '../../../examples/attributes/non-financial/tokenization'
Transaction         = require '../../../../src/genesis/transactions/non_financial/tokenization/cryptogram'
Base                = require '../../base'

describe 'Cryptogram request', ->
  beforeEach ->
    fakeData                    = new FakeData()
    @data                       = fakeData.getTokenizationData()
    @data.token                 = faker.datatype.uuid()
    @data.transaction_reference = faker.datatype.uuid()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'with valid request', ->
    it 'works with full list of parameters', ->
      data = _.clone(@data)
      assert.isTrue @transaction.setData(data).isValid()

  context 'with invalid request', ->
    it 'without transaction_reference', ->
      delete @data.transaction_reference

      assert.isNotTrue @transaction.setData(@data).isValid()

  TokenizationExample()
