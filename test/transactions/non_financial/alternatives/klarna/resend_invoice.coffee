path       = require 'path'
_          = require 'underscore'
faker      = require 'faker'

Base        = require '../../../base'
FakeConfig  = require path.resolve './test/transactions/fake_config'
Builder     = require path.resolve './src/genesis/builder'
Transaction =
  require path.resolve(
    './src/genesis/transactions/non_financial/alternatives/klarna/resend_invoice'
  )

describe 'Klarna Resend Invoice', ->

  before ->
    @data        =
      transaction_id: faker.datatype.uuid()

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  it 'resolves the direct klarna service endpoint on the gate app', ->
    url = @transaction.getArguments().url

    assert.equal url.app, 'gate'
    assert.equal url.path, 'klarna/resend_invoice'

  it 'does not append a terminal token to the url', ->
    assert.isUndefined @transaction.getArguments().url.token

  it 'uses the XML builder interface', ->
    assert.equal @transaction.builderInterface, 'xml'

  it 'serializes the resend_invoice_request root', ->
    document = new Builder('xml').getDocument(@transaction.getTrxData())

    assert.include document, '<resend_invoice_request>'
    assert.include document, "<transaction_id>#{@data.transaction_id}</transaction_id>"

  it 'validates a request with a transaction_id', ->
    assert.isTrue @transaction.setData(_.clone @data).isValid()

  it 'fails without transaction_id', ->
    assert.isFalse @transaction.setData(_.omit @data, 'transaction_id').isValid()

  it 'fails when transaction_id exceeds 255 characters', ->
    data = _.clone @data
    data.transaction_id = _.times(256, -> 'a').join('')

    assert.isFalse @transaction.setData(data).isValid()

  Base()
