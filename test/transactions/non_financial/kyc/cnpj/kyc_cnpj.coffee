path  = require 'path'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction = require path.resolve './src/genesis/transactions/non_financial/kyc/cnpj/kyc_cnpj'

describe 'KYC CNPJ Request', ->

  beforeEach ->
    @data = {
      document_id: '123456'
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  Base()

  it 'with document_id string parameter', ->
    @data.document_id = '123'
    assert.isTrue @transaction.setData(@data).isValid()

  it 'without document_id parameter', ->
    @data = {}
    assert.isNotTrue @transaction.setData(@data).isValid()

  it 'with proper endpoint url', ->
    assert.equal @transaction.getUrl().path, '/api/v1/cnpj/123456'

  it 'with json builder interface', ->
    assert.equal @transaction.builderInterface, 'json'
