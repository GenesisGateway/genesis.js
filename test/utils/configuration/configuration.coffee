path = require('path')

Config      = require path.resolve './src/genesis/utils/configuration/config'
FakeConfig  = require path.resolve './test/transactions/fake_config'
FakeData    = require path.resolve './test/transactions/fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/authorize'

describe 'ManualConfiguration', ->

  beforeEach ->
    @data = (new FakeData).getDataWithBusinessAttributes()

    @configParams = FakeConfig.getConfigData()

  it 'works with proper configuration object', ->
    @configParams.customer.username = "username"
    @configParams.customer.password = "password"
    @configParams.customer.token    = "token"
    @configParams.gateway.hostname  = "test.com"

    configuration = new Config @configParams

    cnf_obj = {
      customer      : {
        "username"            : "username",
        "password"            : "password",
        "token"               : "token",
        "force_smart_routing" : false,
      },
      gateway       : {
        "protocol" : "https",
        "hostname" : "test.com",
        "timeout"  : "60000",
        "testing"  : true
      },
      notifications : {
        "host"     : "<hostname>"
        "port"     : "<port>"
        "path"     : "<path>"
      }
    };

    assert.deepEqual cnf_obj, configuration.getConfig()

  it 'works with all config properties', ->
    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValid()

  it 'works without customer token', ->
    delete @configParams.customer.token

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValid()

  it 'works without customer force_smart_routing property ', ->
    delete @configParams.customer.force_smart_routing

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValid()

  it 'works without gateway protocol property ', ->
    delete @configParams.gateway.protocol

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValid()

  it 'works without gateway timeout property ', ->
    delete @configParams.gateway.timeout

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValid()

  it 'when gateway timeout with default value', ->
    delete @configParams.gateway.timeout

    config = new Config @configParams

    assert.equal config.getGatewayTimeout(), 60000

  it 'when gateway timeout with invalid number property', ->
    @configParams.gateway.timeout = '123aaa'

    config = new Config @configParams

    assert.equal config.getGatewayTimeout(), 60000

  it 'when gateway timeout with proper number value', ->
    @configParams.gateway.timeout = '123'

    config = new Config @configParams

    assert.isNumber config.getGatewayTimeout()
    assert.equal config.getGatewayTimeout(), 123

  it 'works without notifications object', ->
    delete @configParams.notifications

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValid()

  it 'returns gate subdomain for prod environment', ->
    @configParams.gateway.testing = false

    config = new Config @configParams

    assert.equal 'gate', config.getSubDomain('gate')

  it 'returns wpf subdomain for prod environment', ->
    @configParams.gateway.testing = false

    config = new Config @configParams

    assert.equal 'wpf', config.getSubDomain('wpf')

  it 'returns prod.api subdomain for prod environment', ->
    @configParams.gateway.testing = false

    config = new Config @configParams

    assert.equal 'prod.api', config.getSubDomain('smart_router')

  it 'returns kyc subdomain for prod environment', ->
    @configParams.gateway.testing = false

    config = new Config @configParams

    assert.equal 'kyc', config.getSubDomain('kyc')

  it 'returns staging.gate environment subdomain', ->
    config = new Config @configParams

    assert.equal 'staging.gate', config.getSubDomain('gate')

  it 'returns staging.wpf environment subdomain', ->
    config = new Config @configParams

    assert.equal 'staging.wpf', config.getSubDomain('wpf')

  it 'returns staging.api environment subdomain', ->
    config = new Config @configParams

    assert.equal 'staging.api', config.getSubDomain('smart_router')

  it 'returns staging.kyc environment subdomain', ->
    config = new Config @configParams

    assert.equal 'staging.kyc', config.getSubDomain('kyc')

  it 'throws error with invalid subdomain', ->
    config = new Config @configParams

    subdomain = 'invalid_subdomain'

    expect(config.getSubDomain.bind(config, subdomain)).to.throw(
      Error, "Invalid subdomain value provided: #{subdomain}"
    )

  it 'throws error with missing subdomain', ->
    config = new Config @configParams

    expect(config.getSubDomain.bind(config)).to.throw(Error)
    expect(config.getSubDomain.bind(config, null)).to.throw(Error)

  it 'fails with missing customer object', ->
    delete @configParams.customer

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with missing customer username property', ->
    delete @configParams.customer.username

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with missing customer password property', ->
    delete @configParams.customer.password

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with missing gateway node', ->
    delete @configParams.gateway

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with missing gateway hostname property', ->
    delete @configParams.gateway.hostname

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with missing gateway testing property', ->
    delete @configParams.gateway.testing

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with wrong gateway hostname property', ->
    @configParams.gateway.hostname = "test.net"

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with null value of customer force_smart_routing property', ->
    @configParams.customer.force_smart_routing = null

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with string value of customer force_smart_routing property', ->
    @configParams.customer.force_smart_routing = "true"

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with null value of gateway testing property', ->
    @configParams.gateway.testing = null

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()

  it 'fails with string value of customer testing property', ->
    @configParams.gateway.testing = "true"

    config      = new Config @configParams
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValid()
