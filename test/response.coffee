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

  describe 'when XML payload with account_owner', ->
    beforeEach ->
      sinon.stub(Network.prototype, 'getResponseContentType').returns('text/xml; charset=utf-8')
      sinon.stub(Network.prototype, 'getResponseHeaders').returns({})
      sinon.stub(Network.prototype, 'getResponseStatus').returns(200)
      sinon.stub(Network.prototype,'getResponseBody').returns(
        '<?xml version="1.0" encoding="UTF-8"?>
          <payment_response>
            <transaction_type>sale</transaction_type>
            <status>approved</status>
            <account_owner>
              <first_name>Travis</first_name>
              <middle_name>Joe</middle_name>
              <last_name>Pastrana</last_name>
              <full_name_match>Partial match</full_name_match>
              <first_name_match>Match</first_name_match>
              <middle_name_match>No match</middle_name_match>
              <last_name_match>Match</last_name_match>
              <type>personal</type>
            </account_owner>
          </payment_response>'
      )

      network   = new Network()
      @response = new Response(network)

    afterEach ->
      sinon.verifyAndRestore()

    it 'with account_owner first_name element', ->
      assert.equal @response.getResponseObject().account_owner.first_name, 'Travis'

    it 'with account_owner middle_name element', ->
      assert.equal @response.getResponseObject().account_owner.middle_name, 'Joe'

    it 'with account_owner last_name element', ->
      assert.equal @response.getResponseObject().account_owner.last_name, 'Pastrana'

    it 'with account_owner full_name_match element', ->
      assert.equal @response.getResponseObject().account_owner.full_name_match, 'Partial match'

    it 'with account_owner first_name_match element', ->
      assert.equal @response.getResponseObject().account_owner.first_name_match, 'Match'

    it 'with account_owner middle_name_match element', ->
      assert.equal @response.getResponseObject().account_owner.middle_name_match, 'No match'

    it 'with account_owner last_name_match element', ->
      assert.equal @response.getResponseObject().account_owner.last_name_match, 'Match'

    it 'with account_owner type element', ->
      assert.equal @response.getResponseObject().account_owner.type, 'personal'

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
