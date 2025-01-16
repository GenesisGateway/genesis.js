FinancialBase = require '../financial_base'
RequiredBillingAddress = require '../../../examples/attributes/required_billing_address'
_             = require 'underscore'

AlternativeBase = () ->

  FinancialBase()
  RequiredBillingAddress()

  context 'with Alternative Base request', ->

    context 'with invalid parameters', ->

      it 'fails when missing required remote_ip parameter', ->
        # Skips for PPRO transaction type
        if not _.contains(@transaction.getData(), 'ppro', 'transaction_type') and
           not _.contains(@transaction.getData(), 'poli', 'transaction_type') and
           not _.contains(@transaction.getData(), 'sofort', 'transaction_type') and
           not _.contains(@transaction.getData(), 'santander', 'transaction_type') and
           not _.contains(@transaction.getData(), 'webpay', 'transaction_type')

          data = _.clone(@data)
          delete data.remote_ip
          assert.equal false, @transaction.setData(data).isValid()
        else
          @skip()

      it 'fails when missing required return_success_url parameter', ->
        data = _.clone(@data)
        delete data.return_success_url
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when missing required return_failure_url parameter', ->
        data = _.clone(@data)
        delete data.return_failure_url
        assert.equal false, @transaction.setData(data).isValid()

      it 'fails when missing required customer_email parameter', ->
        # Skips for PPRO transaction type
        if not _.contains(@transaction.getData(), 'ppro', 'transaction_type') and
           not _.contains(@transaction.getData(), 'cash', 'transaction_type')

          data = _.clone(@data)
          delete data.customer_email
          assert.equal false, @transaction.setData(data).isValid()
        else
          @skip()

      it 'fails when missing required country parameter', ->
        data = _.clone @data
        delete data.billing_address.country
        assert.equal false, @transaction.setData(data).isValid()


module.exports = AlternativeBase
