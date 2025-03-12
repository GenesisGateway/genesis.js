Transaction  = require '../../../../src/genesis/transactions/non_financial/installments/show_details'
FakeConfig   = require '../../fake_config'
BaseExamples = require '../../base'
faker        = require 'faker'

describe 'Installments Show Details API service', ->
  beforeEach ->
    @uuid        = faker.datatype.uuid()
    @data        =
      installment_id: @uuid

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint', ->
      assert.equal @transaction.getUrl().path, "v1/installments/#{@uuid}"

    it 'with proper builder', ->
      assert.equal @transaction.builderInterface, 'get'

  describe 'when invalid request', ->
    it 'with invalid identifier datatype', ->
      @data.installment_id = 123

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without installment_id', ->
      delete @data.installment_id

      assert.isNotTrue @transaction.setData(@data).isValid()
