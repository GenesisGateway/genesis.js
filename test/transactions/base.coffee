path    = require 'path'
_       = require 'underscore'
sinon   = require 'sinon'
Request = require path.resolve './src/genesis/request'

Base = () ->

  context 'with Base request', ->

    context 'with invalid parameters', ->

      it 'raises validation error with additional property', ->
        data = _.clone @data
        data.NON_EXISTING_PROPERTY = 'INVALID_PROPERTY'

        assert.equal false, @transaction.setData(data).isValid()

    context 'with valid request', ->

      it 'sanitization on empty properties', ->
        data = _.clone @data
        data.NON_EXISTING_PROPERTY = ''

        assert.equal true, @transaction.setData(data).isValid()

      it 'sanitization on null properties', ->
        data = _.clone @data
        data.NON_EXISTING_PROPERTY = null

        assert.equal true, @transaction.setData(data).isValid()

      it 'calls request send method if data is valid', ->
        try
          send = sinon.stub(Request.prototype, 'send').returns(true)

          @transaction.setData(@data).send()

          sinon.assert.calledOnce(send)
        catch e
          throw e
        finally
          send.restore()

module.exports = Base
