Xml = require '../../src/genesis/parsers/xml'

describe 'Xml Parser', ->
  beforeEach ->
    @parser       = new Xml()
    @xmlDocument  = '<?xml version="1.0" encoding="UTF-8"?><tokenize_response><token>1234</token><status>active</status></tokenize_response>'

  it 'should be initialized', ->
    assert.isObject @parser

  it 'with default empty object', ->
    assert.deepEqual @parser.getObject(), {}

  it 'with default root node', ->
    assert.isNotTrue @parser.parseRootNode

  it 'with skip root node', ->
    assert.isTrue @parser.skipRootNode()
    assert.isTrue @parser.parseRootNode

  it 'when parses XML document with root node', ->
    @parser.parseDocument(@xmlDocument)

    assert.deepEqual @parser.getObject(), { tokenize_response: { token: 1234, status: 'active' } }

  it 'when parsers XML document with attributes', ->
    xmlDocument = '<?xml version="1.0" encoding="UTF-8"?>
      <responses attr1="value1" attr2="value2">
      <response>
        <token>1234</token><status>active</status>
      </response>
      </responses>'
    @parser.skipRootNode()
    @parser.parseDocument(xmlDocument)

    assert.deepEqual(
      @parser.getObject(),
      { response: { token: 1234, status: 'active' }, attr1: 'value1', attr2: 'value2'}
    )

  it 'when parses XML document without root node', ->
    @parser.skipRootNode()
    @parser.parseDocument(@xmlDocument)

    assert.deepEqual @parser.getObject(), { token: 1234, status: 'active' }

  it 'when invalid XML document', ->
    @parser.skipRootNode()
    @parser.parseDocument('invalid_document')

    assert.deepEqual @parser.getObject(), {}
