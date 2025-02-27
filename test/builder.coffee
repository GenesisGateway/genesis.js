Builder = require '../src/genesis/builder'
Xml     = require '../src/genesis/builders/xml'
Json    = require '../src/genesis/builders/json'
Form    = require '../src/genesis/builders/form'

context 'Request Builder', ->
  context 'when default builder', ->
    before ->
      @builder = new Builder()

    it 'when default builder', ->
      assert.equal @builder.context, null

    it 'with empty document', ->
      assert.equal @builder.getDocument({ param1: 'value1' }), ''

  context 'when XML builder', ->
    before ->
      @builder = new Builder('xml')

    it 'with XML builder context', ->
      assert.isTrue @builder.context instanceof Xml

    it 'with XML document', ->
      assert.equal @builder.getDocument({ param1: 'value1' }), "<?xml version='1.0'?>\n<param1>value1</param1>"

  context 'when JSON builder', ->
    before ->
      @builder = new Builder('json')

    it 'with JSON builder context', ->
      assert.isTrue @builder.context instanceof Json

    it 'with JSON document', ->
      assert.equal @builder.getDocument({ param1: 'value1' }), '{"param1":"value1"}'

  context 'when FORM builder', ->
    before ->
      @builder = new Builder('form')

    it 'with FORM builder context', ->
      assert.isTrue @builder.context instanceof Form

    it 'with FORM document', ->
      assert.equal @builder.getDocument({ param1: 'value1' }), 'param1=value1'
