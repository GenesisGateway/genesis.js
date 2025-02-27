Xml = require '../../src/genesis/builders/xml'

describe 'XML builder', ->
  beforeEach ->
    @structure = { payment_request: { param1: 'value1', param2: 'value2' } }
    @xml       = new Xml()

  it 'when JSON object to string document', ->
    assert.isString @xml.buildStructure(@structure)

  it 'when JSON object with proper document', ->
    assert.equal(
      @xml.buildStructure(@structure),
      "<?xml version='1.0'?>\n<payment_request>\n\x20\x20\x20\x20<param1>value1</param1>\n\x20\x20\x20\x20<param2>value2</param2>\n</payment_request>"
    )

  it 'when JSON object without root element', ->
    assert.equal @xml.buildStructure({ param1: 'value1', param2: 'value2' }), "<?xml version='1.0'?>\n<param1>value1</param1>"

  it 'when empty structure', ->
    assert.equal @xml.buildStructure({ }), "<?xml version='1.0'?>"
