path  = require 'path'
_     = require 'underscore'
ajv   = require 'ajv'

SchemaLoader     = require path.resolve './src/genesis/transactions/schema_loader'
Validator        = require path.resolve './src/genesis/transactions/validator'
Sale             = require path.resolve './src/genesis/transactions/financial/cards/sale'
FakeConfig       = require path.resolve './test/transactions/fake_config'
FakeData         = require path.resolve './test/transactions/fake_data'

# Minimal transaction double for exercising the Validator in isolation.
class MockTransaction
  constructor: (@type, @data = {}) ->
  getTransactionType: -> @type
  getData: -> @data

describe 'Schema Autoloader', ->

  describe 'loadTransactionSchema', ->

    # Requirement 6.2: every transaction type the autoloader indexes resolves
    # to a schema, and each resolved schema keeps its $id.
    it 'resolves a schema for every indexed transaction type', ->
      index = SchemaLoader.getTransactionIndex()
      types = Object.keys(index)

      expect(types.length).to.be.above(0)

      for type in types
        schema = SchemaLoader.loadTransactionSchema(type)
        expect(schema, "schema for #{type}").to.be.an('object')
        expect(schema.$id, "$id for #{type}").to.be.a('string')

    it 'resolves representative flat types regardless of subdirectory', ->
      expect(SchemaLoader.loadTransactionSchema('sale').$id).to.equal 'https://genesis.js/sale'
      expect(SchemaLoader.loadTransactionSchema('boleto').$id).to.equal 'https://genesis.js/boleto'
      expect(SchemaLoader.loadTransactionSchema('wpf_create').$id)
        .to.equal 'https://genesis.js/wpf_create'

    # Filename/class mismatches resolve by the transaction-type string.
    # The index is keyed on the transaction-type string (the file name), not
    # on $id. container_store.json carries a pre-existing typo'd $id
    # ('caontainer_store') that must stay byte-identical after the move.
    it 'resolves types whose filename differs from the class name', ->
      expect(SchemaLoader.loadTransactionSchema('void').$id).to.equal 'https://genesis.js/void'
      containerStore = SchemaLoader.loadTransactionSchema('container_store')
      expect(containerStore).to.be.an('object')
      expect(containerStore.$id).to.equal 'https://genesis.js/caontainer_store'

    # Requirement 3.6: duplicate transaction-type keys fail fast.
    it 'throws when two files map to the same transaction type', ->
      stub = sinon.stub(SchemaLoader, 'collectJsonFiles').returns([
        '/schemas/transactions/financial/cards/sale.json'
        '/schemas/transactions/financial/other/sale.json'
      ])
      # Force the index to rebuild with the stubbed file list.
      delete SchemaLoader._transactionIndex

      try
        expect(-> SchemaLoader.getTransactionIndex()).to.throw(/Duplicate transaction schema/)
      finally
        stub.restore()
        delete SchemaLoader._transactionIndex

  describe 'Validator integration', ->

    # Requirement 2.3 / 6.3: an unknown type still yields the existing error.
    it 'reports "JSON schema not found" for an unknown transaction type', ->
      validator = new Validator(new MockTransaction('does_not_exist', {}))

      assert.isFalse validator.isValid()
      assert.deepEqual validator.getErrors(),
        [ { message: 'JSON schema not found for this request' } ]

    # Requirement 4.3 / 6.4: a $ref-dependent transaction validates, proving
    # the definition schemas are registered through the autoloader.
    it 'validates a $ref-dependent card sale (definitions registered)', ->
      data        = (new FakeData).getData()
      transaction = new Sale(data, FakeConfig.getConfig())

      assert.isTrue transaction.validator.isValid()
      assert.deepEqual transaction.validator.getErrors(), []

  describe 'registerDefinitions', ->

    it 'registers every schema under schemas/definitions/', ->
      instance = new ajv(allErrors: true)
      SchemaLoader.registerDefinitions(instance)

      defFiles = SchemaLoader.collectJsonFiles(SchemaLoader.DEFINITIONS_DIR)
      expect(defFiles.length).to.be.above(0)

      for file in defFiles
        id = (require file).$id
        expect(instance.getSchema(id), "registered #{id}").to.exist
