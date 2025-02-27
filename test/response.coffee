Response = require '../src/genesis/response'
Network  = require '../src/genesis/networks/axios_api'

describe 'Response module', ->
  describe 'when default empty network', ->
    beforeEach ->
      sinon.stub(Network.prototype, 'getResponseContentType').returns('text/xml; charset=utf-8')
      sinon.stub(Network.prototype, 'getResponseHeaders').returns({})

      network   = new Network()
      @response = new Response(network)

    afterEach ->
      sinon.verifyAndRestore()

    it 'when initialized Response with Network', ->
      assert.isObject @response

    it 'when initialized Response with empty document', ->
      assert.deepEqual {}, @response.getResponseObject()

    it 'when response headers', ->
      assert.deepEqual {}, @response.getResponseHeaders()

    it 'when empty raw response', ->
      assert.deepEqual '', @response.getResponseRaw()

    it 'when zero response code', ->
      assert.equal 0, @response.getResponseCode()

  describe 'when XML payload', ->
    beforeEach ->
      sinon.stub(Network.prototype, 'getResponseContentType').returns('text/xml; charset=utf-8')
      sinon.stub(Network.prototype, 'getResponseHeaders').returns({})
      sinon.stub(Network.prototype, 'getResponseStatus').returns(200)
      sinon.stub(Network.prototype,'getResponseBody').returns(
        '<?xml version="1.0" encoding="UTF-8"?>
          <payment_response>
            <transaction_type>sale</transaction_type>
            <status>approved</status>
            <amount>99</amount>
            <currency>EUR</currency>
          </payment_response>'
      )

      network   = new Network()
      @response = new Response(network)

    afterEach ->
      sinon.verifyAndRestore()

    it 'with response object in JSON format', ->
      assert.isObject @response.getResponseObject()

    it 'with response status', ->
      assert.equal @response.getResponseCode(), 200

    it 'with transaction type element', ->
      assert.equal @response.getResponseObject().transaction_type, 'sale'

    it 'without root node', ->
      expect(@response.getResponseObject()).to.not.have.nested.property('payment_response')

    it 'with transformed amount', ->
      assert.equal @response.getResponseObject().amount, 0.99

  describe 'when JSON payload', ->
    beforeEach ->
      sinon.stub(Network.prototype, 'getResponseContentType').returns('application/json; charset=utf-8')
      sinon.stub(Network.prototype, 'getResponseHeaders').returns({})
      sinon.stub(Network.prototype, 'getResponseStatus').returns(200)
      sinon.stub(Network.prototype,'getResponseBody').returns(
        '{
            "transaction_type": "sale",
            "status": "approved",
            "amount": "99",
            "currency": "EUR"
        }'
      )

      network   = new Network()
      @response = new Response(network)

    afterEach ->
      sinon.verifyAndRestore()

    it 'with response object in JSON format', ->
      assert.isObject @response.getResponseObject()

    it 'with response status', ->
      assert.equal @response.getResponseCode(), 200

    it 'with transaction type element', ->
      assert.equal @response.getResponseObject().transaction_type, 'sale'

    it 'without root node', ->
      expect(@response.getResponseObject()).to.not.have.nested.property('payment_response')

    it 'with transformed amount', ->
      assert.equal @response.getResponseObject().amount, 0.99
