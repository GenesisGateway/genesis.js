Form = require '../../src/genesis/builders/form'

describe 'FORM builder', ->
  beforeEach ->
    @structure = { param1: 'value1', param2: 'value2' }
    @form      = new Form()

  it 'when JSON object to string document', ->
    assert.isString @form.buildStructure(@structure)

  it 'when JSON object with proper document', ->
    assert.equal @form.buildStructure(@structure), 'param1=value1&param2=value2'

  it 'when empty structure', ->
    assert.equal @form.buildStructure({}), ''

