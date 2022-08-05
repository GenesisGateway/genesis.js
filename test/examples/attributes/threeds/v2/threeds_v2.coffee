faker = require 'faker'
_     = require 'underscore'
Types = require '../../../../../src/genesis/helpers/transaction/types'

ThreedsV2 = () ->

  class ThreedsV2Attributes
    @getThreedsV2: (transactionType, transactionData) ->
      if transactionType == Types.INIT_RECURRING_SALE_3D
        @getRecurringParams(transactionData)
      else
        @getParams(transactionData)

    @getRecurringParams: (transactionData) ->
      recurringData = @getParams(transactionData)

      recurringData.threeds_v2_params = _.extend(
        recurringData.threeds_v2_params,
        {
          recurring:
            expiration_date: "19-07-2021"
            frequency: 10
        }
      )

      recurringData

    @getParams: (transactionData) ->
      _.extend(
        transactionData,
        {
          threeds_v2_params:
            threeds_method:
              callback_url: "https://www.example.com/threeds/threeds_method/callback"
            control:
              device_type: "browser"
              challenge_window_size: "full_screen"
              challenge_indicator: "preference"
            purchase:
              category: "service"
            merchant_risk:
              shipping_indicator: "verified_address"
              delivery_timeframe: "electronic"
              reorder_items_indicator: "reordered"
              pre_order_purchase_indicator: "merchandise_available"
              pre_order_date: "19-08-2022"
              gift_card: "true"
              gift_card_count: 2
            card_holder_account:
              creation_date: "19-07-2021"
              update_indicator: "more_than_60days"
              last_change_date: "19-04-2022"
              password_change_indicator: "no_change"
              password_change_date: "04-07-2022"
              shipping_address_usage_indicator: "current_transaction"
              shipping_address_date_first_used: "14-07-2022"
              transactions_activity_last_24_hours: 2
              transactions_activity_previous_year: 10
              provision_attempts_last_24_hours: 1
              purchases_count_last_6_months: 5
              suspicious_activity_indicator: "no_suspicious_observed"
              registration_indicator: "30_to_60_days"
              registration_date: "19-07-2020"
            browser:
              accept_header: "*/*"
              java_enabled: false
              language: "en-GB"
              color_depth: 24
              screen_height: 900
              screen_width: 1440
              time_zone_offset: "-120"
              user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36"
            sdk:
              interface: "native"
              ui_types:
                ui_type: "multi_select"
              application_id: "fc1650c0-5778-0138-8205-2cbc32a32d65"
              encrypted_data: "encrypted-data-here"
              ephemeral_public_key_pair: "public-key-pair"
              max_timeout: 10
              reference_number: "sdk-reference-number-here"
        }
      )

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
