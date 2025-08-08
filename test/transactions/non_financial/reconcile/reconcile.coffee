path   = require 'path'
_      = require 'underscore'
faker  = require 'faker'
config = require 'config'

Base        = require '../../base'
FakeConfig          = require path.resolve './test/transactions/fake_config'
Transaction         = require path.resolve './src/genesis/transactions/non_financial/reconcile/reconcile'
Config              = require path.resolve './src/genesis/utils/configuration/config'

describe 'Reconcile Transaction', ->

  beforeEach ->
    @data =
      unique_id:      faker.random.alphaNumeric(),
      transaction_id: faker.random.alphaNumeric(),
      arn: faker.random.alphaNumeric()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  describe 'when invalid request', ->
    it 'fails when missing required parameter', ->
      assert.isFalse @transaction.setData(
        _.omit @data, ['transaction_id', 'unique_id', 'arn']
      ).isValid()

  describe 'when valid request', ->
    it 'works only with unique_id', ->
      assert.isTrue @transaction.setData(_.omit @data, 'transaction_id').isValid()

    it 'works only with transaction_id', ->
      assert.isTrue @transaction.setData(_.omit @data, 'unique_id').isValid()

    it 'works only with arn', ->
      assert.isTrue @transaction.setData(_.omit @data, 'arn').isValid()

  describe 'when using smart router', ->
    beforeEach ->
      @params = {
        customer : {
          "username"            : "username",
          "password"            : "123456",
          "token"               : "",
          "force_smart_routing" : true,
        },
        gateway : {
          "protocol" : "https",
          "hostname" : "emerchantpay.net",
          "timeout"  : "60000",
          "testing"  : true
        },
        notifications : {
          "host"     : "<hostname>",
          "port"     : "<port>",
          "path"     : "<path>"
        }
      }

      @configuration = new Config @params
      @data = {}
      @data.transaction_id = faker.random.alphaNumeric() unless @data.transaction_id
      @data.use_smart_router = true
      @transaction = new Transaction(@data, @configuration)

    it 'with smart router', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint', ->
      assert.equal(
          @transaction.formatUrl(@transaction.getArguments().url),
          "https://staging.api.#{@transaction.configuration.getGatewayHostname()}/reconcile"
        )

    it 'without smart router', ->
      params                              = _.clone(@params)
      params.customer.force_smart_routing = false
      params.customer.token               = faker.datatype.uuid()

      config      = new Config(params)
      data        = { transaction_id: faker.random.alphaNumeric() }
      transaction = new Transaction(data, config)

      assert.equal(
        transaction.formatUrl(transaction.getArguments().url),
        "https://staging.gate.#{transaction.configuration.getGatewayHostname()}/reconcile/#{params.customer.token}"
      )

  Base()
