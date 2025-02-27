path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Transaction =
  require path.resolve './src/genesis/transactions/non_financial/kyc/consumer_registration/kyc_update_consumer'

describe 'KYC Create Consumer Request', ->

  before ->
    @data = {
      reference_id: faker.datatype.number().toString()
      profile_current_status: faker.random.arrayElement([0, 1, 2, 3])
    }

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'with json builder interface', ->
    assert.equal @transaction.builderInterface, 'json'

  it 'fails when missing required parameters', ->
    data = _.clone @data
    delete data.reference_id
    delete data.profile_current_status
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'fails with invalid profile_current_status parameter', ->
    data = _.clone @data
    data.profile_current_status = 'invalid_value'
    assert.isNotTrue @transaction.setData(data).isValid()

  it 'works with all required parameters', ->
    assert.isTrue @transaction.setData(@data).isValid()

  it 'works with all parameters', ->
    data = _.clone @data
    data.status_reason = "Reject"
    assert.isTrue @transaction.setData(data).isValid()

  Base()
