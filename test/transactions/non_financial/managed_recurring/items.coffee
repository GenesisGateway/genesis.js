Transaction  = require '../../../../src/genesis/transactions/non_financial/managed_recurring/items'
FakeConfig   = require '../../fake_config'
BaseExamples = require '../../base'
faker        = require 'faker'

describe 'Managed Recurring Items API service', ->
  beforeEach ->
    @data        = {}

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint', ->
      assert.equal @transaction.getUrl().path, 'v1/managed_recurring/items'

    it 'with proper builder', ->
      assert.equal @transaction.builderInterface, 'get'
