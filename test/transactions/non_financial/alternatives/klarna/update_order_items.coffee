path       = require 'path'
_          = require 'underscore'
faker      = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Builder     = require path.resolve './src/genesis/builder'
Transaction =
  require path.resolve(
    './src/genesis/transactions/non_financial/alternatives/klarna/update_order_items'
  )

buildItem = ->
  item_type:    'physical'
  quantity:     1
  unit_price:   5000
  total_amount: 5000
  reference:    faker.random.alphaNumeric(10)
  name:         faker.commerce.productName()

describe 'Klarna Update Order Items', ->

  before ->
    @data        =
      transaction_id: faker.datatype.uuid()
      amount:         10000
      items:
        item: [buildItem(), buildItem()]

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'resolves the direct klarna service endpoint on the gate app', ->
    url = @transaction.getArguments().url

    assert.equal url.app, 'gate'
    assert.equal url.path, 'klarna/update_order_items'

  it 'does not append a terminal token to the url', ->
    assert.isUndefined @transaction.getArguments().url.token

  it 'uses the XML builder interface', ->
    assert.equal @transaction.builderInterface, 'xml'

  it 'serializes the update_order_items_request root', ->
    document = new Builder('xml').getDocument(@transaction.getTrxData())

    assert.include document, '<update_order_items_request>'

  it 'serializes one <item> per line item inside a single <items> wrapper', ->
    document = new Builder('xml').getDocument(@transaction.getTrxData())

    assert.equal (document.match(/<items>/g) || []).length, 1
    assert.equal (document.match(/<item>/g) || []).length, 2

  # item_type DECISION regression: the serialized element MUST be <item_type>,
  # matching the gateway parameter table. We never emit <type> and never alias it.
  it 'serializes the line-item type as <item_type> and never as <type>', ->
    document = new Builder('xml').getDocument(@transaction.getTrxData())

    assert.include document, '<item_type>physical</item_type>'
    assert.notInclude document, '<type>'

  it 'serializes nested product_identifiers and merchant_data wrappers', ->
    data = _.clone @data
    data.items =
      item:
        item_type:    'physical'
        quantity:     1
        unit_price:   5000
        total_amount: 5000
        product_identifiers:
          brand:                    'Acme'
          global_trade_item_number: '0001234567890'
        merchant_data:
          marketplace_seller_info: 'seller-42'

    document = new Builder('xml').getDocument({ update_order_items_request: data })

    assert.include document, '<product_identifiers>'
    assert.include document, '<brand>Acme</brand>'
    assert.include document, '<merchant_data>'
    assert.include document, '<marketplace_seller_info>seller-42</marketplace_seller_info>'

  describe 'when valid request', ->
    it 'validates a single-item payload', ->
      data = _.clone @data
      data.items = { item: buildItem() }

      assert.isTrue @transaction.setData(data).isValid()

    it 'validates a multi-item payload', ->
      assert.isTrue @transaction.setData(_.clone @data).isValid()

  describe 'when invalid request', ->
    it 'fails without amount', ->
      assert.isFalse @transaction.setData(_.omit @data, 'amount').isValid()

    it 'fails with a non-positive amount', ->
      data = _.clone @data
      data.amount = 0

      assert.isFalse @transaction.setData(data).isValid()

    it 'fails without items', ->
      assert.isFalse @transaction.setData(_.omit @data, 'items').isValid()

    it 'fails when a required item field is missing', ->
      data = _.clone @data
      data.items = { item: _.omit(buildItem(), 'item_type') }

      assert.isFalse @transaction.setData(data).isValid()

    it 'fails on an additional item property', ->
      data = _.clone @data
      item = buildItem()
      item.NON_EXISTING_PROPERTY = 'INVALID'
      data.items = { item }

      assert.isFalse @transaction.setData(data).isValid()

  Base()
