Json = require '../../src/genesis/parsers/json'

describe 'Json Parser', ->
  beforeEach ->
    @parser       = new Json()
    @jsonDocument = [{ id: 1, name: 'Test', enabled: true }]

  it 'should be initialized', ->
    assert.isObject @parser

  it 'with default empty object', ->
    assert.deepEqual {}, @parser.getObject()

  it 'with default root node', ->
    assert.isNotTrue @parser.parseRootNode

  it 'with skip root node', ->
    assert.isTrue @parser.skipRootNode()
    assert.isTrue @parser.parseRootNode

  it 'parses string document', ->
    @parser.parseDocument('[{"id":1,"name":"Test","enabled":true}]')

    assert.deepEqual @jsonDocument, @parser.getObject()

  it 'parses Json document', ->
    @parser.parseDocument(@jsonDocument)

    assert.deepEqual @jsonDocument, @parser.getObject()

  it 'ignores skip root node ', ->
    @parser.skipRootNode()
    @parser.parseDocument('{"root": {"id": "1234"}}')

    assert.deepEqual { root: { id: '1234' } }, @parser.getObject()

  it 'when invalid JSON document', ->
    @parser.skipRootNode()
    @parser.parseDocument('invalid_document')

    assert.deepEqual {}, @parser.getObject()
