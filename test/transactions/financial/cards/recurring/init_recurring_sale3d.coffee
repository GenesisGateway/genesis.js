path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData    = require '../../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/cards/recurring/init_recurring_sale3d'
CardBase    = require '../card_base'

describe 'InitRecurringSale 3D Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

    @data['notification_url']   = faker.internet.url();
    @data['return_success_url'] = faker.internet.url();
    @data['return_failure_url'] = faker.internet.url();

  CardBase()

  it 'fails when missing asynchronous required parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'notification_url').isValid()
