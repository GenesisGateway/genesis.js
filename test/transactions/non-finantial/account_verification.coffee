path  = require 'path'
_     = require 'underscore'

FakeData    = require '../fake_data'
Transaction = require path.resolve './src/genesis/transactions/non_financial/account_verification'
Base        = require '../base'

describe 'AccountVerification Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

  Base()

  it 'fails when missing required address1 parameter', ->
    data = _.clone @data
    data['billing_address'] = _.omit data['billing_address'], 'address1'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing required zip_code parameter', ->
    data = _.clone @data
    data['billing_address'] = _.omit data['billing_address'], 'zip_code'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing required city parameter', ->
    data = _.clone @data
    data['billing_address'] = _.omit data['billing_address'], 'city'
    assert.equal false, @transaction.setData(data).isValid()
