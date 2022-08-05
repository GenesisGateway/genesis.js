path = require('path')

Currency = require path.resolve './src/genesis/helpers/currency'

describe 'Currency', ->

  before ->
    @currency = new Currency()

  context 'with valid converting', ->

    context 'when converting a number value', ->

      it 'returns 1000 when converting 10 to minor units', ->
        assert.equal '1000', @currency.convertToMinorUnits(10, 'USD')

      it 'returns 10.00 when converting 1000 to major units', ->
        assert.equal '10.00', @currency.convertToNominalUnits(1000, 'USD')

      it 'returns 99 when converting 0.99 to minor units', ->
        assert.equal '99', @currency.convertToMinorUnits(0.99, 'EUR')

      it 'returns 0.99 when converting 99 to major units', ->
        assert.equal '0.99', @currency.convertToNominalUnits(99, 'EUR')

    context 'when converting a string value', ->

      it 'returns 1000 when converting 10 to minor units', ->
        assert.equal '1000', @currency.convertToMinorUnits('10', 'USD')

      it 'returns 10.00 when converting 1000 to major units', ->
        assert.equal '10.00', @currency.convertToNominalUnits('1000', 'USD')

      it 'returns 99 when converting 0.99 to minor units', ->
        assert.equal '99', @currency.convertToMinorUnits('0.99', 'EUR')

      it 'returns 0.99 when converting 99 to major units', ->
        assert.equal '0.99', @currency.convertToNominalUnits('99', 'EUR')
