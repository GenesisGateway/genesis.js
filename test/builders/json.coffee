Json = require '../../src/genesis/builders/json'

describe 'JSON builder', ->
  beforeEach ->
    @structure = { payment_request: { param1: 'value1', param2: 'value2' } }
    @json      = new Json()

  it 'when JSON object to string document', ->
    assert.isString @json.buildStructure(@structure)

  it 'when JSON object with proper document', ->
    assert.equal @json.buildStructure(@structure), '{"payment_request":{"param1":"value1","param2":"value2"}}'

  it 'when empty structure', ->
    assert.equal @json.buildStructure({}), '{}'
