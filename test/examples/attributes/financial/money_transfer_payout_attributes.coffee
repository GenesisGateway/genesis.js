_        = require 'underscore'

MoneyTransferPayoutAttributes = () ->

  describe 'Money Transfer Payout Attributes', ->
    beforeEach ->
      @moneyTransferData = _.clone @data
      @moneyTransferData = _.extend(@moneyTransferData,
        {
          money_transfer:
            type: 'account_to_account'
            sender_account_number: '123456789'
            sender_birth_date: '01-01-1990'
            service_provider_name: 'Test Provider'
            sender_account_number_type: 'iban'
            purpose_of_payment: 'family_support'
            source_of_funds: 'credit'
            sender_address:
              first_name: 'John'
              last_name: 'Doe'
              country: 'US'
              city: 'New York'
              zip_code: '10001'
              address1: '123 Main St'
              state: 'NY'
            receiver:
              first_name: 'Jane'
              last_name: 'Doe'
              country: 'GB'
              city: 'London'
              state: 'LND'
              zip_code: 'EC1A 1BB'
              address1: '456 High St'
        }
      )

    it 'works with money_transfer', ->
      assert.isTrue @transaction.setData(@moneyTransferData).isValid()

    it 'works without money_transfer', ->
      assert.isTrue @transaction.setData(@data).isValid()

    it 'fail with invalid type', ->
      @moneyTransferData.money_transfer.type = 'invalid'

      assert.isNotTrue @transaction.setData(@moneyTransferData).isValid()

    it 'fail with invalid sender_account_number_type', ->
      @moneyTransferData.money_transfer.sender_account_number_type = 'invalid'

      assert.isNotTrue @transaction.setData(@moneyTransferData).isValid()

    it 'fail with invalid source_of_funds', ->
      @moneyTransferData.money_transfer.source_of_funds = 'invalid'

      assert.isNotTrue @transaction.setData(@moneyTransferData).isValid()

    it 'fail when money_transfer node with additional properties', ->
      @moneyTransferData.money_transfer.element = 'value'

      assert.isNotTrue @transaction.setData(@moneyTransferData).isValid()

    it 'fail when sender_address node with additional properties', ->
      @moneyTransferData.money_transfer.sender_address.element = 'value'

      assert.isNotTrue @transaction.setData(@moneyTransferData).isValid()

    it 'fail when receiver node with additional properties', ->
      @moneyTransferData.money_transfer.receiver.element = 'value'

      assert.isNotTrue @transaction.setData(@moneyTransferData).isValid()

    it 'fail when receiver country with invalid value', ->
      @moneyTransferData.money_transfer.receiver.country = 'invalid'

      assert.isNotTrue @transaction.setData(@moneyTransferData).isValid()

module.exports = MoneyTransferPayoutAttributes
