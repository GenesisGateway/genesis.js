_     = require 'underscore'

ModeList = ()  ->
  context 'with Mode List request', ->
    context 'when invalid request', ->
      it 'fails with invalid mode parameter', ->
        data = _.clone @data
        data.mode = 'invalid_mode_value'
        assert.isNotTrue @transaction.setData(data).isValid()

    context 'when valid request', ->
      it 'works with mode parameter', ->
        data = _.clone @data
        data.mode = 'list'
        assert.isTrue @transaction.setData(data).isValid()

module.exports = ModeList
