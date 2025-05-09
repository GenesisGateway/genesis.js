path     = require 'path'
faker    = require 'faker'
_        = require 'underscore'
Currency = require path.resolve './src/genesis/helpers/currency'

class FakeData

  constructor: ->
    @data =
      _.extend(
        {},
        @getMinimumData(),
        'currency':
          faker.random.arrayElement (new Currency).getCurrencies()
        'amount':
          faker.datatype.number().toString()
        'customer_email':
          faker.internet.email()
        'customer_phone':
          faker.phone.phoneNumber()
      )

  getMinimumData: ->
    'transaction_id':
      faker.datatype.number().toString()
    'usage':
      'Genesis JS Client Automated Request'
    'remote_ip':
      faker.random.arrayElement([faker.internet.ip(), faker.internet.ipv6()])

  getCCData: ->
    'card_holder':
      faker.name.findName()
    'card_number':
      '4200000000000000'
    'cvv':
      faker.datatype.number({min: 100, max: 999}).toString() #fix this to generate numbers like 003
    'expiration_month':
      faker.datatype.number({min: 1, max: 12}).toString()
    'expiration_year':
      faker.datatype.number({
        min: (new Date).getFullYear(),
        max: (new Date).getFullYear()+5
      }).toString()

  getBillingData: ->
    'billing_address':
      'first_name':
        faker.name.firstName()
      'last_name':
        faker.name.lastName()
      'address1':
        faker.address.streetAddress()
      'zip_code':
        faker.address.zipCode()
      'city':
        faker.address.city()
      'neighborhood':
        faker.address.city()
      'country':
        faker.address.countryCode()

  getShippingData: ->
    'shipping_address':
      'first_name':
        faker.name.firstName()
      'last_name':
        faker.name.lastName()
      'address1':
        faker.address.streetAddress()
      'zip_code':
        faker.address.zipCode()
      'city':
        faker.address.city()
      'neighborhood':
        faker.address.city()
      'country':
        faker.address.countryCode()

  getBusinessAttributesData: ->
    'business_attributes':
      'flight_arrival_date': '10-10-2020',
      'flight_departure_date': '10-10-2020',
      'airline_code': faker.datatype.number().toString(),
      'flight_ticket_number': faker.datatype.number().toString(),
      'flight_origin_city': faker.address.city(),
      'flight_destination_city': faker.address.city(),
      'airline_tour_operator_name': faker.company.companyName(),
      'event_start_date': '12-10-2021',
      'event_end_date': '01-10-2021',
      'event_organizer_id': faker.datatype.number().toString(),
      'event_id': faker.datatype.number().toString(),
      'date_of_order': '12-10-2020',
      'delivery_date': '31-12-2020',
      'name_of_the_supplier': faker.company.companyName(),
      'check_in_date': '12-10-2020',
      'check_out_date': '16-10-2020',
      'travel_agency_name': faker.company.companyName(),
      'vehicle_pick_up_date': '11-10-2020',
      'vehicle_return_date': '12-10-2020',
      'supplier_name': faker.company.companyName(),
      'cruise_start_date': '12-10-2020',
      'cruise_end_date': '12-11-2020',
      'arrival_date': '12-12-2020',
      'departure_date': '13-12-2020',
      'carrier_code': faker.datatype.number().toString(),
      'flight_number': faker.datatype.number().toString(),
      'ticket_number': faker.datatype.number().toString(),
      'origin_city': faker.address.city(),
      'destination_city': faker.address.city(),
      'travel_agency': faker.company.companyName(),
      'contractor_name': faker.company.companyName(),
      'atol_certificate': faker.datatype.number().toString(),
      'pick_up_date': '12-10-2020',
      'return_date': '24-10-2020',
      'payment_type': 'deposit'

  getManagedRecurringManual: ->
    'mode': 'manual',
    'payment_type': 'subsequent',
    'amount_type': 'fixed',
    'frequency': 'weekly',
    'registration_reference_number': faker.datatype.number().toString(),
    'max_amount': 100,
    'max_count': 5,
    'validated': true

  getManagedRecurringAutomatic: ->
    'mode': 'automatic',
    'interval': 'days',
    'first_date': '2022-10-03',
    'time_of_day': 5,
    'period': 1,
    'amount': faker.datatype.number().toString()

  getGooglePaymentTokenData: ->
    'signature': faker.datatype.number().toString(),
    'protocolVersion': 'ECv2',
    'signedMessage':
      'tag': faker.datatype.number().toString(),
      'ephemeralPublicKey': faker.datatype.number().toString(),
      'encryptedMessage': faker.datatype.number().toString()
    'intermediateSigningKey':
      'signedKey':
        'keyExpiration': faker.datatype.number().toString(),
        'keyValue': faker.datatype.number().toString()
      'signatures': faker.datatype.number().toString()

  getApplePaymentTokenData: ->
    "paymentData": {
      "version": "EC_v1",
      "data": faker.datatype.number().toString(),
      "signature": faker.datatype.number().toString(),
      "header": {
        "ephemeralPublicKey": faker.datatype.number().toString(),
        "publicKeyHash": faker.datatype.number().toString(),
        "transactionId": faker.datatype.number().toString()
      }
    },
    "paymentMethod": {
      "displayName": "Visa 0225",
      "network": "Visa",
      "type": "debit"
    },
    "transactionIdentifier": faker.datatype.number().toString()

  getTokenizationData: ->
    'consumer_id': faker.datatype.number().toString()
    'email': faker.internet.email()
    'token_type': 'uuid'

  getThreedsV2Data: ->
    threeds_v2_params:
      threeds_method:
        callback_url: 'https://www.example.com/threeds/threeds_method/callback'
      control:
        device_type: 'browser'
        challenge_window_size: 'full_screen'
        challenge_indicator: 'preference'
      purchase:
        category: 'service'
      merchant_risk:
        shipping_indicator: 'verified_address'
        delivery_timeframe: 'electronic'
        reorder_items_indicator: 'reordered'
        pre_order_purchase_indicator: 'merchandise_available'
        pre_order_date: '19-08-2022'
        gift_card: 'true'
        gift_card_count: 2
      card_holder_account:
        creation_date: '19-07-2021'
        update_indicator: 'more_than_60days'
        last_change_date: '19-04-2022'
        password_change_indicator: 'no_change'
        password_change_date: '04-07-2022'
        shipping_address_usage_indicator: 'current_transaction'
        shipping_address_date_first_used: '14-07-2022'
        transactions_activity_last_24_hours: 2
        transactions_activity_previous_year: 10
        provision_attempts_last_24_hours: 1
        purchases_count_last_6_months: 5
        suspicious_activity_indicator: 'no_suspicious_observed'
        registration_indicator: '30_to_60_days'
        registration_date: '19-07-2020'
      browser:
        accept_header: '*/*'
        java_enabled: false
        language: 'en-GB'
        color_depth: '24'
        screen_height: 900
        screen_width: 1440
        time_zone_offset: '-120'
        user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36'
      sdk:
        interface: 'native'
        ui_types:
          ui_type: 'multi_select'
        application_id: 'fc1650c0-5778-0138-8205-2cbc32a32d65'
        encrypted_data: 'encrypted-data-here'
        ephemeral_public_key_pair: 'public-key-pair'
        max_timeout: 10
        reference_number: 'sdk-reference-number-here'

  getThreedsV2RecurringData: ->
    recurring:
      expiration_date: '19-07-2021'
      frequency: 10

  getMpiParams: ->
    'mpi_params':
      'cavv': faker.datatype.number().toString()
      'eci': faker.datatype.number().toString()
      'xid': faker.datatype.number().toString()
      'protocol_version': '2'
      'protocol_sub_version': '9'
      'directory_server_id': faker.datatype.number().toString()
      'acs_transaction_id': faker.datatype.number().toString()

  getFundingData: ->
    funding:
      identifier_type: faker.random.arrayElement([
        'general_person_to_person', 'person_to_person_card_account', 'own_account', 'own_credit_card_bill',
        'business_disbursement', 'government_or_non_profit_disbursement', 'rapid_merchant_settlement',
        'general_business_to_business', 'own_staged_digital_wallet_account', 'own_debit_or_prepaid_card_account'
      ])
      business_application_identifier: faker.random.arrayElement([
        'funds_disbursement', 'pension_disbursement', 'account_to_account', 'bank_initiated', 'fund_transfer',
        'person_to_person', 'prepaid_card_load', 'wallet_transfer', 'liquid_assets'
      ])
      receiver:
        first_name:          faker.random.alpha(10)
        last_name:           faker.random.alpha(10)
        country:             'AF',
        account_number:      faker.datatype.number().toString(),
        account_number_type: faker.random.arrayElement([
          'rtn_and_bank_account_number', 'iban', 'card_account', 'email', 'phone_number',
          'bank_account_number_and_bic', 'wallet_id', 'social_network_id', 'other'
        ])
        address:             faker.random.alpha(10)
        state:               faker.random.alpha(10)
        city:                faker.random.alpha(10)
      sender:
        name:             faker.random.alpha(10)
        reference_number: faker.random.alpha(10)
        country:          'AF'
        address:          faker.random.alpha(10)
        state:            faker.random.alpha(10)
        city:             faker.random.alpha(10)

  getLevel3TravelData: ->
    travel:
      ticket:
        ticket_number:               faker.datatype.number().toString()
        passenger_name:              faker.random.alpha(12)
        customer_code:               '1'
        issuing_carrier:             faker.random.alpha(4)
        total_fare:                  5000
        agency_name:                 faker.random.alpha(6)
        agency_code:                 faker.random.alpha(5)
        confirmation_information:    faker.random.alpha(12)
        date_of_issue:               '2018-02-01'
        restricted_ticket_indicator: '1'
        ticket_reference_id:         faker.random.alpha(32)
        ticket_document_number:      faker.random.alpha(15)
        issued_with_ticket_number:   faker.random.alpha(15)
      rentals:
        car_rental:
          purchase_identifier:       faker.random.alpha(9)
          class_id:                  '3'
          pickup_date:               '2018-02-05'
          renter_name:               'Emil Example'
          return_city:               'Varna'
          return_state:              'VAR'
          return_country:            'BGR'
          return_date:               '2018-02-06'
          renter_return_location_id: faker.random.alpha(10)
          customer_code:             faker.random.alpha(17)
          extra_charges:             [1,2]
          no_show_indicator:         '0'
        hotel_rental:
          purchase_identifier: faker.random.alpha(10)
          arrival_date:        '2018-02-05'
          departure_date:      '2018-02-05'
          customer_code:       faker.random.alpha(17)
          extra_charges:       [2,3]
          no_show_indicator:   '0'
      charges:
        charge:
          type: 'MISC'
      legs:
        leg: [
          @getLevel3TravelLegData()
          @getLevel3TravelLegData()
        ]
      taxes:
        tax: [
          @getLevel3TravelTaxData()
          @getLevel3TravelTaxData()
        ]

  getLevel3TravelLegData: ->
    departure_date:         '2018-02-01'
    carrier_code:           '2'
    service_class:          '3'
    origin_city:            faker.random.alpha(3)
    destination_city:       faker.random.alpha(3)
    stopover_code:          '1'
    fare_basis_code:        faker.random.alpha(5)
    flight_number:          faker.random.alpha(5)
    departure_time:         '11:37'
    departure_time_segment: 'A'

  getLevel3TravelTaxData: ->
    fee_amount: 1000,
    fee_type:   faker.random.alpha(8)

  getSimpleData: ->
    @data

  getSimpleDataAndBusinessAttributes: ->
    _.extend(
      {},
      @data,
      @getBusinessAttributesData()
    )

  getData: ->
    _.extend(
      {},
      @data,
      @getCCData(),
      @getBillingData()
    )

  getApmData: ->
    _.extend(
      {},
      @data,
      @getBillingData()
    )

  getDataWithBusinessAttributes: ->
    _.extend(
      {},
      @data,
      @getCCData(),
      @getBillingData()
      @getBusinessAttributesData()
    )

module.exports = FakeData
