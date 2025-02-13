path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeConfig         = require path.resolve './test/transactions/fake_config'
FakeData           = require '../../fake_data'
Transaction        = require path.resolve './src/genesis/transactions/financial/obp/wechat'

describe 'Wechat Transaction', ->

  beforeEach ->
    @data                       = (new FakeData).getApmData()
    @data['currency']           = 'EUR'
    @data['notification_url']   = faker.internet.url()
    @data['return_url']         = faker.internet.url()
    @data['usage']              = '40208 concert tickets'
    @data['product_code']       = faker.datatype.number().toString()
    @data['product_num']        = faker.datatype.number().toString()
    @data['product_desc']       = 'Product description'

    @transaction                = new Transaction(@data, FakeConfig.getConfig())

  context 'with valid request', ->

    it 'works with full list of parameters', ->
      data = _.clone(@data)

      assert.equal true, @transaction.setData(data).isValid()

  context 'with invalid request', ->

    it 'failed when missing notification_url parameter', ->
      data = _.clone(@data)
      delete data['notification_url']

      assert.equal false, @transaction.setData(data).isValid()

    it 'failed when missing return_url parameter', ->
      data = _.clone(@data)
      delete data['return_url']

      assert.equal false, @transaction.setData(data).isValid()

    it 'failed when missing usage parameter', ->
      data = _.clone(@data)
      delete data['usage']

      assert.equal false, @transaction.setData(data).isValid()

    it 'fails when missing required country parameter', ->
      data = _.clone @data
      delete data['billing_address']['country']

      assert.equal false, @transaction.setData(data).isValid()
