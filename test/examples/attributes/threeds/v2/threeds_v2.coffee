_        = require 'underscore'
Types    = require '../../../../../src/genesis/helpers/transaction/types'
FakeData = require '../../../../transactions/fake_data'

ThreedsV2 = () ->

  class ThreedsV2Attributes
    @getThreedsV2: (transactionType, transactionData) ->
      if transactionType == Types.INIT_RECURRING_SALE_3D
        @getRecurringParams(transactionData)
      else
        @getParams(transactionData)

    @getRecurringParams: (transactionData) ->
      recurringData = @getParams(transactionData)

      recurringData.threeds_v2_params =
        _.extend(recurringData.threeds_v2_params, (new FakeData).getThreedsV2RecurringData())

      recurringData

    @getParams: (transactionData) ->
      _.extend(transactionData, (new FakeData).getThreedsV2Data())

  context 'with Threeds V2 Attributes', ->

    context 'with valid request', ->

      it 'valid threeds_v2_params structure', ->
        data = ThreedsV2Attributes.getThreedsV2(@transaction.getTransactionType(), _.clone(@data))
        assert.equal true, @transaction.setData(data).isValid()

      it 'request contains threeds_v2_params', ->
        data = ThreedsV2Attributes.getThreedsV2(@transaction.getTransactionType(), _.clone(@data))
        @transaction.setData(data)

        expect(
          @transaction.getTrxData()
        ).to.have.nested.property(
          'payment_transaction.threeds_v2_params'
        )

    context 'with invalid request', ->

      it 'fail with recurring for non recurring types', ->
        data = ThreedsV2Attributes.getThreedsV2(Types.INIT_RECURRING_SALE_3D, _.clone(@data))

        if @transaction.getTransactionType() != Types.INIT_RECURRING_SALE_3D
          assert.equal false, @transaction.setData(data).isValid()

module.exports = ThreedsV2
