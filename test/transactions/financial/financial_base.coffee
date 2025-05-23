Base                = require '../base'
_                   = require 'underscore'
SmartRouterExamples = require '../../examples/attributes/financial/smart_router_attributes'
Types               = require '../../../src/genesis/helpers/transaction/types'

FinancialBase = () ->

  it 'fails when missing required transaction_id parameter', ->
    data = _.clone(@data)
    delete data.transaction_id
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing required amount parameter', ->
    data = _.clone(@data)
    delete data.amount
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when missing required currency parameter', ->
    @skip() if @transaction.getTransactionType() == Types.PARTIAL_REVERSAL
    data = _.clone(@data)
    delete data.currency
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong amount parameter', ->
    data = _.clone @data
    data.amount = -1000
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails when wrong currency parameter', ->
    data = _.clone @data
    data['currency'] = 'NOT_VALID_CURRENCY'
    assert.equal false, @transaction.setData(data).isValid()

  it 'works with integer amount parameter', ->
    data = _.clone @data
    data['amount'] = 100
    assert.equal true, @transaction.setData(data).isValid()

  it 'works with number amount parameter', ->
    data = _.clone @data
    data['amount'] = 1.11
    assert.equal true, @transaction.setData(data).isValid()

  it 'works with string amount parameter', ->
    data = _.clone @data
    data['amount'] = "1.11"
    assert.equal true, @transaction.setData(data).isValid()

  it 'works with zero amount', ->
    data = _.clone @data
    data['amount'] = 0

    assert.equal true, @transaction.setData(data).isValid()

  it 'works with minor amount format', ->
    data = _.clone @data
    data['currency'] = 'EUR'
    data['amount']   = '1.99'
    amount           = ''
    trxData          = @transaction.setData(data).getTrxData()

    if trxData.payment_transaction then amount = trxData.payment_transaction.amount
    if trxData.wpf_payment then amount         = trxData.wpf_payment.amount

    assert.equal '199', amount

  Base()
  SmartRouterExamples()

module.exports = FinancialBase
