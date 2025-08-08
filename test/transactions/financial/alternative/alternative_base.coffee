FinancialBase          = require '../financial_base'
RequiredBillingAddress = require '../../../examples/attributes/required_billing_address'
_                      = require 'underscore'

AlternativeBase = ->

  FinancialBase()
  RequiredBillingAddress()

  context 'with Alternative Base request', ->

    context 'with invalid parameters', ->

      it 'fails when missing required remote_ip parameter', ->
        skipRemoteIpTypes = ['ppro', 'poli', 'sofort', 'santander', 'webpay', 'upi', 'rapi_pago']

        if @transaction.getData().transaction_type not in skipRemoteIpTypes
          data = _.omit(@data, 'remote_ip')
          assert.isFalse @transaction.setData(data).isValid()
        else
          @skip()

      it 'fails when missing required return_success_url parameter', ->
        data = _.omit(@data, 'return_success_url')
        assert.isFalse @transaction.setData(data).isValid()

      it 'fails when missing required return_failure_url parameter', ->
        data = _.omit(@data, 'return_failure_url')
        assert.isFalse @transaction.setData(data).isValid()

      it 'fails when missing required customer_email parameter', ->

        skipCustomerEmailTps = ['ppro', 'cash', 'upi', 'rapi_pago']
        if @transaction.getData().transaction_type not in skipCustomerEmailTps
          data = _.omit(@data, 'customer_email')
          assert.isFalse @transaction.setData(data).isValid()
        else
          @skip()

      it 'fails when missing required country parameter', ->
        data = _.clone @data
        delete data.billing_address.country
        assert.isFalse @transaction.setData(data).isValid()

module.exports = AlternativeBase
