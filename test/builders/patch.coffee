PATCH = require '../../src/genesis/builders/patch'

describe 'JSON PATCH builder', ->
  beforeEach ->
    @structure = { payment_request: { param1: 'value1', param2: 'value2' } }
    @patch      = new PATCH()

  it 'when JSON object to string document', ->
    assert.isString @patch.buildStructure(@structure)

  it 'when JSON object with proper document', ->
    assert.equal @patch.buildStructure(@structure), '{"payment_request":{"param1":"value1","param2":"value2"}}'

  it 'when empty structure', ->
    assert.equal @patch.buildStructure({}), '{}'
