path = require('path')

Config      = require path.resolve './src/genesis/utils/configuration/config'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/authorize'
FakeData    = require path.resolve './test/transactions/fake_data'
faker = require 'faker'

describe 'ManualConfiguration', ->

  before ->
    @data = (new FakeData).getDataWithBusinessAttributes()

  it 'works with proper configuration object', ->

    configParams = {
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

    configuration = new Config configParams

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

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : false,
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValidConfig()

  it 'works without customer token', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        force_smart_routing : false,
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValidConfig()

  it 'works without customer force_smart_routing property ', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValidConfig()

  it 'works without gateway protocol property ', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
      },
      gateway : {
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValidConfig()

  it 'works without gateway timeout property ', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
      },
      gateway : {
        protocol : "https",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValidConfig()

  it 'works without notifications object', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
      },
      gateway : {
        protocol : "https",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal true, transaction.isValidConfig()

  it 'fails with missing customer object', ->

    configParam = {
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with missing customer username property', ->

    configParam = {
      customer      : {
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with missing customer password property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with missing gateway node', ->

    configParam = {
      customer      : {
        "username"            : faker.random.alpha(40),
        "password"            : faker.random.alpha(40),
        "token"               : faker.random.alpha(40),
        "force_smart_routing" : false,
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()


  it 'fails with missing gateway hostname property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : false,
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with missing gateway testing property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : false,
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : faker.random.arrayElement(['emerchantpay.net', 'e-comprocessing.net']),
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with wrong gateway hostname property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : false,
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : "test.net",
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with null value of customer force_smart_routing property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : null,
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : "test.net",
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with string value of customer force_smart_routing property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : "true",
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : "test.net",
        testing  : true
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with null value of gateway testing property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : false,
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : "test.net",
        testing  : null
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()

  it 'fails with string value of customer testing property', ->

    configParam = {
      customer      : {
        username            : faker.random.alpha(40),
        password            : faker.random.alpha(40),
        token               : faker.random.alpha(40),
        force_smart_routing : "true",
      },
      gateway : {
        protocol : "https",
        timeout  : "60000",
        hostname : "test.net",
        testing  : "true"
      },
      notifications: {
        host : "<hostname>",
        port : "<port>",
        path : "<path>"
      }
    };

    config      = new Config configParam
    transaction = new Transaction(@data, config)

    assert.equal false, transaction.isValidConfig()



