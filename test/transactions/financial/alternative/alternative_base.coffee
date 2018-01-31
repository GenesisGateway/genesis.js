FinancialBase = require '../financial_base'
_             = require 'underscore'

AlternativeBase = () ->

  FinancialBase()

  it 'fails when missing required remote_ip parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'remote_ip').isValid()

  it 'fails when missing required return_success_url parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'return_success_url').isValid()

  it 'fails when missing required return_failure_url parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'return_failure_url').isValid()

  it 'fails when missing required customer_email parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'customer_email').isValid()

  it 'fails when missing required country parameter', ->
    data = _.clone @data
    data['billing_address'] = _.omit data['billing_address'], 'country';
    assert.equal false, @transaction.setData(data).isValid()


module.exports = AlternativeBase