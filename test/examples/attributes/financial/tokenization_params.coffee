_     = require 'underscore'
faker = require 'faker'

TokenizationParams = () ->

  describe 'Tokenization Params', ->
    beforeEach ->
      @tokenizationData = _.clone @data
      @tokenizationData = _.extend(
        @tokenizationData, { 'tokenization_params': { 'eci': '05', 'tavv': faker.datatype.uuid() } }
      )

    describe 'when valid params', ->
      it 'works with tokenization_params', ->
        assert.isTrue @transaction.setData(@tokenizationData).isValid()

    describe 'when invalid params', ->
      it 'with invalid eci', ->
        @tokenizationData.tokenization_params.eci = '123'

        assert.isNotTrue @transaction.setData(@tokenizationData).isValid()

      it 'with invalid tavv', ->
        @tokenizationData.tokenization_params.tavv = faker.random.alpha(256)

        assert.isNotTrue @transaction.setData(@tokenizationData).isValid()

      it 'with additional properties', ->
        @tokenizationData.tokenization_params.field = 'value'

        assert.isNotTrue @transaction.setData(@tokenizationData).isValid()

module.exports = TokenizationParams
