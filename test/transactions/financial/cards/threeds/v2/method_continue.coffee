faker       = require 'faker'
crypto      = require 'crypto'
path        = require 'path'
_           = require 'underscore'
config      = require 'config'
Transaction = require(
  path.resolve './src/genesis/transactions/financial/cards/threeds/v2/method_continue'
)

describe 'Method Continue', ->

  beforeEach ->
    config.customer.password = "123456"
    unique_id = 'asf87as8df67a8sd7f6as8d7f6a8sd7f6a8sd7f6'
    @data =
      unique_id: unique_id
      amount: '10.00'
      currency: 'EUR'
      timestamp: '12-10-2020'
    @transaction = new Transaction(@data)

  it 'work with correct generated signature value', ->

    signature = crypto.createHash('sha512')
      .update(@data.unique_id + '1000' + @data.timestamp + config.customer.password)
      .digest('hex')

    assert.equal signature, @transaction.getSignature()

  it 'fail without required parameter unique_id', ->
    data = _.clone(@data)
    delete data.unique_id

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail without required parameter amount', ->
    data = _.clone(@data)
    delete data.amount

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail without required parameter currency', ->
    data = _.clone(@data)
    delete data.currency

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail without required parameter timestamp', ->
    data = _.clone(@data)
    delete data.timestamp

    assert.equal false, @transaction.setData(data).isValid()



