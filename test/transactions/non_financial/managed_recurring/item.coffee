Transaction  = require '../../../../src/genesis/transactions/non_financial/managed_recurring/item'
FakeConfig   = require '../../fake_config'
BaseExamples = require '../../base'
faker        = require 'faker'

describe 'Managed Recurring Item API service', ->
  beforeEach ->
    @uuid        = faker.datatype.uuid()
    @data        =
      unique_id: @uuid

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint', ->
      assert.equal @transaction.getUrl().path, "v1/managed_recurring/items/#{@uuid}"

    it 'with proper builder', ->
      assert.equal @transaction.builderInterface, 'get'

  describe 'when invalid request', ->
    it 'with invalid identifier datatype', ->
      @data.unique_id = 123

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without unique_id', ->
      delete @data.unique_id

      assert.isNotTrue @transaction.setData(@data).isValid()
