path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData      = require '../fake_data'
Transaction   = require path.resolve './src/genesis/transactions/wpf/create'
FinancialBase = require '../financial/financial_base'
i18n          = require path.resolve 'src/genesis/helpers/i18n'

describe 'WPFCreate Transaction', ->

  before ->
    @data        = (new FakeData).getData()
    @transaction = new Transaction()

    @data['transaction_types']  = ['sale']
    @data['locale']             = faker.random.arrayElement((new i18n).getLocales())
    @data['notification_url']   = faker.internet.url()
    @data['return_success_url'] = faker.internet.url()
    @data['return_failure_url'] = faker.internet.url()
    @data['return_cancel_url']  = faker.internet.url()

  it 'fails when missing required transaction_types parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'transaction_types').isValid()

  it 'fails when wrong transaction_type', ->
    data = _.clone @data
    data.transaction_types = ['NOT_VALID_TYPE']
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong locale', ->
    data = _.clone @data
    data.locale = 'NOT_VALID_LOCALE'
    assert.equal false, @transaction.setData(data).isValid()

  FinancialBase()
