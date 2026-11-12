path       = require 'path'
_          = require 'underscore'
faker      = require 'faker'
Promise    = require 'bluebird'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Builder     = require path.resolve './src/genesis/builder'
Network     = require path.resolve './src/genesis/networks/axios_api'
Transaction =
  require path.resolve(
    './src/genesis/transactions/non_financial/alternatives/klarna/release_remaining_authorization'
  )

describe 'Klarna Release Remaining Authorization', ->

  before ->
    @data        =
      transaction_id: faker.datatype.uuid()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'resolves the direct klarna service endpoint on the gate app', ->
    url = @transaction.getArguments().url

    assert.equal url.app, 'gate'
    assert.equal url.path, 'klarna/release_remaining_authorization'

  it 'does not append a terminal token to the url', ->
    assert.isUndefined @transaction.getArguments().url.token

  it 'uses the XML builder interface', ->
    assert.equal @transaction.builderInterface, 'xml'

  it 'serializes the release_remaining_authorization_request root', ->
    document = new Builder('xml').getDocument(@transaction.getTrxData())

    assert.include document, '<release_remaining_authorization_request>'
    assert.include document, "<transaction_id>#{@data.transaction_id}</transaction_id>"

  it 'validates a request with a transaction_id', ->
    assert.isTrue @transaction.setData(_.clone @data).isValid()

  it 'fails without transaction_id', ->
    assert.isFalse @transaction.setData(_.omit @data, 'transaction_id').isValid()

  it 'fails when transaction_id exceeds 255 characters', ->
    data = _.clone @data
    data.transaction_id = _.times(256, -> 'a').join('')

    assert.isFalse @transaction.setData(data).isValid()

  describe 'when the network boundary is stubbed', ->
    afterEach ->
      sinon.restore()

    it 'posts XML to the direct klarna url and resolves the parsed response', ->
      response = { status: 'approved', technical_message: 'OK' }
      sinon.stub(Network.prototype, 'doRequest').returns(Promise.resolve(response))

      transaction = new Transaction(_.clone(@data), FakeConfig.getConfig())
      transaction.network = new Network()

      options = transaction.initConfiguration()
      assert.equal options.method, 'POST'
      assert.equal options.headers['Content-Type'], 'text/xml'

      assert.equal(
        transaction.formatUrl(transaction.getArguments().url),
        "https://staging.gate.#{transaction.configuration.getGatewayHostname()}" +
          "/klarna/release_remaining_authorization"
      )

      transaction.send().then (parsed) ->
        assert.deepEqual parsed, response

  Base()
