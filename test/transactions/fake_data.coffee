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
      faker.internet.ip()

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
