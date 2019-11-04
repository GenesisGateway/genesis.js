path = require('path')

Currency = require path.resolve './src/genesis/helpers/currency'

describe 'Currency', ->

  before ->
    @currency = new Currency()

  it 'returns 1000 when converting 10 to minor units', ->
    assert.equal '1000', @currency.convertToMinorUnits(10, 'USD')

  it 'returns 10.00 when converting 1000 to normal units', ->
    assert.equal '10.00', @currency.convertToNominalUnits(1000, 'USD')