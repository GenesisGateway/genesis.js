_                   = require 'underscore'
faker               = require 'faker'
FakeConfig          = require '../../fake_config'
FakeData            = require '../../fake_data'
TokenizationExample = require '../../../examples/attributes/non-financial/tokenization'
CardDataExample     = require '../../../examples/attributes/non-financial/tokenization_card_data'
Transaction         = require '../../../../src/genesis/transactions/non_financial/tokenization/update_token'
Base                = require '../../base'

describe 'Update Token request', ->
  beforeEach ->
    fakeData        = new FakeData()

    @data           = fakeData.getTokenizationData()
    @data.token     = faker.datatype.uuid()
    @data.card_data = fakeData.getCCData()
    delete @data.card_data.cvv

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  context 'with valid request', ->
    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.isTrue @transaction.setData(data).isValid()

  CardDataExample()
  TokenizationExample()
