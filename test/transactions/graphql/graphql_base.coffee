path        = require 'path'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Config      = require path.resolve './src/genesis/utils/configuration/config'
GraphqlBase = require path.resolve './src/genesis/transactions/graphql/graphql_base'
Graphql     = require path.resolve './src/genesis/builders/graphql'


describe 'GraphqlBase', ->

  beforeEach ->
    @config = FakeConfig.getConfig()

  afterEach ->
    sinon.verifyAndRestore()

  it 'when builderInterface is graphql', ->
    class TestRequest extends GraphqlBase
      getUrl: -> app: 'gate', path: 'test'
      buildQueryStructure: -> testQuery: fields: ['id']
    request = new TestRequest({}, @config)
    assert.equal request.builderInterface, 'graphql'

  it 'when getUrl throws on base class (abstract)', ->
    request = Object.create(GraphqlBase.prototype)
    fn = -> request.getUrl()
    expect(fn).to.throw('GraphQL request must define getUrl()')

  it 'when buildQueryStructure returns empty object', ->
    class TestRequest extends GraphqlBase
      getUrl: -> app: 'gate', path: 'test'
    request = new TestRequest({}, @config)
    assert.deepEqual request.buildQueryStructure(), {}

  it 'when getTrxData delegates to buildQueryStructure', ->
    class TestRequest extends GraphqlBase
      getUrl: -> app: 'gate', path: 'test'
      buildQueryStructure: -> testQuery: fields: ['id']
    request = new TestRequest({}, @config)
    spy = sinon.spy(request, 'buildQueryStructure')
    request.getTrxData()
    expect(spy).to.have.been.calledOnce

  it 'when authorization uses Bearer token', ->
    class TestRequest extends GraphqlBase
      getUrl: -> app: 'gate', path: 'test'
      buildQueryStructure: -> testQuery: fields: ['id']
    request = new TestRequest({}, @config)
    assert.equal request.getAuthorizationHeader(), "Bearer #{@config.getBillingApiToken()}"

  it 'accepts Bearer-only GraphQL configuration', ->
    config = new Config(
      customer: billing_api_token: 'billing-token'
      gateway:
        hostname: 'emerchantpay.net'
        testing: true
    )
    class TestRequest extends GraphqlBase
      getUrl: -> app: 'gate', path: 'test'
      buildQueryStructure: -> testQuery: fields: ['id']
    request = new TestRequest({}, config)

    assert.isTrue request.isValid()

  it 'rejects a GraphQL configuration without a Billing API token', ->
    configData = FakeConfig.getConfigData()
    delete configData.customer.billing_api_token
    config = new Config(configData)
    class TestRequest extends GraphqlBase
      getUrl: -> app: 'gate', path: 'test'
      buildQueryStructure: -> testQuery: fields: ['id']
    request = new TestRequest({}, config)

    assert.isFalse request.isValid()
    assert.include request.getErrors()[0].message, 'billing_api_token'

  context 'concrete test subclass', ->
    beforeEach ->
      class TestBillingRequest extends GraphqlBase
        getUrl: -> app: 'smart_router', path: 'billing_statements/v1/graphql'
        buildQueryStructure: ->
          billingTransactions:
            filter:
              startDate: '2023-12-20 10:51:22'
              endDate: '2023-12-20 11:06:25'
              transactionType: 'Sale Approved'
            sort:
              byDirection: Graphql.raw('desc')
            paging:
              page: 1
              perPage: 100
            fields: [
              {
                items: [
                  'billingStatement'
                  'uniqueId'
                  'transactionType'
                  'billingAmount'
                  'billingCurrency'
                  'transactionDate'
                  'merchantTransactionId'
                  'paymentType'
                ]
              }
              {
                paging: [
                  'page'
                  'perPage'
                  'pagesCount'
                  'totalCount'
                ]
              }
            ]
      @request = new TestBillingRequest({}, @config)

    # Full serialization output is covered in test/builders/graphql.coffee
    it 'produces a GraphQL query body', ->
      output = new Graphql().buildStructure(@request.getTrxData())
      assert.match output, /^query \{\n  billingTransactions\(filter: \{ startDate: /

    it 'defines the Billing API endpoint', ->
      url = @request.getUrl()
      assert.equal url.app, 'smart_router'
      assert.equal url.path, 'billing_statements/v1/graphql'

    it 'sends the GraphQL query with the Billing API configuration', ->
      networkSend = sinon.stub(@request.network, 'send').resolves('Gateway Response')
      expectedBody = new Graphql().buildStructure(@request.getTrxData())
      hostname = @config.getGatewayHostname()
      expectedUrl = "https://staging.api.#{hostname}/billing_statements/v1/graphql"

      @request.send().then (response) =>
        assert.equal response, 'Gateway Response'
        assert.isTrue networkSend.calledOnceWith(expectedUrl, expectedBody)
        headers = @request.network.networkConfig.headers
        assert.equal headers['Content-Type'], 'application/graphql'
        assert.equal headers['Accept'], 'application/json'
        assert.equal headers['Authorization'], "Bearer #{@config.getBillingApiToken()}"

  context 'request gate', ->
    beforeEach ->
      @networkSend = null
      @stubNetwork = (request) =>
        @networkSend = sinon.stub(request.network, 'send').resolves('Gateway Response')

    it 'rejects an empty query structure', ->
      class TestRequest extends GraphqlBase
        getUrl: -> app: 'gate', path: 'test'
      request = new TestRequest({}, @config)
      @stubNetwork(request)

      assert.isFalse request.isValid()
      assert.include request.getErrors()[0].message, 'must not be empty'

      request.send()
        .then(-> throw Error('Test case do not expect a resolved promise!'))
        .catch((error) =>
          assert.equal error.status, 'INVALID_INPUT'
          assert.isTrue @networkSend.notCalled
        )

    it 'turns builder errors into validation errors', ->
      class TestRequest extends GraphqlBase
        getUrl: -> app: 'gate', path: 'test'
        buildQueryStructure: -> q: fields: []
      request = new TestRequest({}, @config)

      assert.isFalse request.isValid()
      assert.include(
        request.getErrors()[0].message,
        'GraphQL field selection must be a non-empty array'
      )

    it 'builds the document exactly once per send', ->
      class TestRequest extends GraphqlBase
        getUrl: -> app: 'gate', path: 'test'
        buildQueryStructure: -> testQuery: fields: ['id']
      request = new TestRequest({}, @config)
      @stubNetwork(request)
      buildSpy = sinon.spy(request, 'buildQueryStructure')
      documentSpy = sinon.spy(request.builderContext, 'getDocument')

      request.send().then =>
        expect(buildSpy).to.have.been.calledOnce
        expect(documentSpy).to.have.been.calledOnce
        assert.isTrue @networkSend.calledOnce

    it 'dispatches the validated document', ->
      class TestRequest extends GraphqlBase
        calls: 0
        getUrl: -> app: 'gate', path: 'test'
        buildQueryStructure: ->
          @calls += 1
          if @calls == 1 then firstQuery: fields: ['id'] else secondQuery: fields: ['id']
      request = new TestRequest({}, @config)
      @stubNetwork(request)

      request.send().then =>
        body = @networkSend.firstCall.args[1]
        assert.include body, 'firstQuery'
        assert.notInclude body, 'secondQuery'

    it 'rejects when getUrl is not overridden', ->
      class TestRequest extends GraphqlBase
        buildQueryStructure: -> testQuery: fields: ['id']
      request = new TestRequest({}, @config)
      @stubNetwork(request)

      request.send()
        .then(-> throw Error('Test case do not expect a resolved promise!'))
        .catch((error) =>
          assert.instanceOf error, Error
          assert.equal error.message, 'GraphQL request must define getUrl()'
          assert.isTrue @networkSend.notCalled
        )

    it 'runs transaction schema validation when getTransactionType is defined', ->
      class TestRequest extends GraphqlBase
        getUrl: -> app: 'gate', path: 'test'
        getTransactionType: -> 'billing_test'
        buildQueryStructure: -> testQuery: fields: ['id']
      request = new TestRequest({}, @config)
      validatorIsValid = sinon.stub(request.validator, 'isValid').returns(false)

      assert.isFalse request.isValid()
      expect(validatorIsValid).to.have.been.calledOnce

    it 'skips transaction schema validation without getTransactionType', ->
      class TestRequest extends GraphqlBase
        getUrl: -> app: 'gate', path: 'test'
        buildQueryStructure: -> testQuery: fields: ['id']
      request = new TestRequest({}, @config)
      validatorIsValid = sinon.spy(request.validator, 'isValid')

      assert.isTrue request.isValid()
      assert.isTrue validatorIsValid.notCalled

  context 'Validator', ->
    it 'rejects an empty billing_api_token for GraphQL requests', ->
      configData = FakeConfig.getConfigData()
      configData.customer.billing_api_token = ''
      class TestRequest extends GraphqlBase
        getUrl: -> app: 'gate', path: 'test'
        buildQueryStructure: -> testQuery: fields: ['id']
      request = new TestRequest({}, new Config(configData))

      assert.isTrue request.validator.isValidConfig()
      assert.isFalse request.validator.isValidGraphqlConfig()

    it 'rejects an invalid gateway hostname through the shared gateway definition', ->
      configData = FakeConfig.getConfigData()
      configData.gateway.hostname = 'example.com'
      class TestRequest extends GraphqlBase
        getUrl: -> app: 'gate', path: 'test'
        buildQueryStructure: -> testQuery: fields: ['id']
      request = new TestRequest({}, new Config(configData))

      assert.isFalse request.isValid()
      messages = (error.message for error in request.getErrors())
      assert.isTrue(
        messages.some((message) ->
          message.includes('Allowed values are emerchantpay.net, e-comprocessing.net')
        )
      )
