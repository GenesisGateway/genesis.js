path       = require 'path'
_          = require 'underscore'
faker      = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Builder     = require path.resolve './src/genesis/builder'
Transaction =
  require path.resolve(
    './src/genesis/transactions/non_financial/alternatives/klarna/update_order_address'
  )

buildAddress = ->
  first_name: faker.name.firstName()
  last_name:  faker.name.lastName()
  address1:   faker.address.streetAddress()
  zip_code:   faker.address.zipCode()
  city:       faker.address.city()
  country:    'DE'

describe 'Klarna Update Order Address', ->

  before ->
    @data        =
      transaction_id:   faker.datatype.uuid()
      billing_address:  buildAddress()
      shipping_address: buildAddress()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'resolves the direct klarna service endpoint on the gate app', ->
    url = @transaction.getArguments().url

    assert.equal url.app, 'gate'
    assert.equal url.path, 'klarna/update_order_address'

  it 'does not append a terminal token to the url', ->
    assert.isUndefined @transaction.getArguments().url.token

  it 'uses the XML builder interface', ->
    assert.equal @transaction.builderInterface, 'xml'

  it 'serializes separate billing and shipping address wrappers', ->
    document = new Builder('xml').getDocument(@transaction.getTrxData())

    assert.include document, '<update_order_address_request>'
    assert.include document, '<billing_address>'
    assert.include document, '<shipping_address>'

  describe 'when valid request', ->
    it 'validates addresses with a two-letter country', ->
      assert.isTrue @transaction.setData(_.clone @data).isValid()

  describe 'when invalid request', ->
    it 'fails when billing country is missing', ->
      data = _.clone @data
      data.billing_address = _.omit(buildAddress(), 'country')

      assert.isFalse @transaction.setData(data).isValid()

    it 'fails when shipping country is missing', ->
      data = _.clone @data
      data.shipping_address = _.omit(buildAddress(), 'country')

      assert.isFalse @transaction.setData(data).isValid()

    it 'fails on an invalid country code', ->
      data = _.clone @data
      data.billing_address = _.extend(buildAddress(), country: 'ZZ')

      assert.isFalse @transaction.setData(data).isValid()

    it 'fails on a US address with an invalid state', ->
      data = _.clone @data
      data.billing_address = _.extend(buildAddress(), country: 'US', state: 'ZZ')

      assert.isFalse @transaction.setData(data).isValid()

    it 'fails without billing_address', ->
      assert.isFalse @transaction.setData(_.omit @data, 'billing_address').isValid()

    it 'fails without shipping_address', ->
      assert.isFalse @transaction.setData(_.omit @data, 'shipping_address').isValid()

  Base()
