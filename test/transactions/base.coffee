path    = require 'path'
_       = require 'underscore'
sinon   = require 'sinon'
Request = require path.resolve './src/genesis/request'

Base = () ->

  it 'calls request send method if data is valid', ->

    send = sinon.stub(Request.prototype, 'send').returns(true);

    @transaction.setData(@data).send()

    send.restore();
    sinon.assert.calledOnce(send);

module.exports = Base