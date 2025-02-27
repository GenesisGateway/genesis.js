Parser = require '../src/genesis/parser'
Xml    = require '../src/genesis/parsers/xml'
Json   = require '../src/genesis/parsers/json'

describe 'Parser module', ->
  describe 'when XML interface', ->

    beforeEach ->
      @parser = new Parser()
      @parser.skipRootNode()

    it 'when initialized with proper context type', ->
      assert.isTrue @parser.context instanceof Xml

    it 'when getObject with default value', ->
      assert.deepEqual {}, @parser.getObject()

    it 'when skip root node', ->
      assert.isTrue @parser.skipRootNode()

    it 'when parse document', ->
      xml = '<?xml version="1.0" encoding="UTF-8"?><tokenize_response><token>1234</token><status>active</status></tokenize_response>'
      @parser.parseDocument(xml)

      assert.deepEqual { token: 1234, status: 'active' }, @parser.getObject()

  describe 'when JSON interface', ->
    beforeEach ->
      @parser = new Parser('json')
      @parser.skipRootNode()

    it 'when initialized with JSON parser', ->
      assert.isTrue @parser.context instanceof Json

    it 'when getObject with default value', ->
      assert.deepEqual {}, @parser.getObject()

    it 'when skip root node', ->
      assert.isTrue @parser.skipRootNode()

    it 'when parse document', ->
      json = '{ "token": "1234", "status": "active" }'
      @parser.parseDocument(json)

      assert.deepEqual { token: '1234', status: 'active' }, @parser.getObject()

