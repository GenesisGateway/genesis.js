faker = require 'faker'
_     = require 'underscore'

TravelData = () ->

  it 'works with full list of travel data attributes', ->
    data = _.clone @data
    data = _.extend(data, {
      travel: {
        ticket: {
          "ticket_number": faker.datatype.number().toString(),
          "passenger_name": faker.random.alpha(12),
          "customer_code": "1",
          "restricted_ticket_indicator": 1,
          "agency_name": faker.random.alpha(6),
          "agency_code": faker.random.alpha(5),
          "confirmation_information": faker.random.alpha(12),
          "date_of_issue": "2018-02-01"
        },
        rentals: {
          car_rental: {
            purchase_identifier: 12478,
            class_id: 3,
            pickup_date: '2018-02-05',
            renter_name: 'Emil Example',
            return_city: 'Varna',
            return_state: 'VAR',
            return_country: 'BGR',
            return_date: '2018-02-06',
            renter_return_location_id: 12478,
            customer_code: 1
          },
          hotel_rental: {
            purchase_identifier: 12478,
            arrival_date: 3,
            departure_date: '2018-02-05',
            customer_code: 1
          }
        },
        charges: {
          charge: {
            type: 'MISC'
          }
        },
        legs: [
          {
            "departure_date": "2018-02-01",
            "carrier_code": "2",
            "service_class": "3",
            "origin_city": faker.random.alpha(3),
            "destination_city": faker.random.alpha(3),
            "stopover_code": "1",
            "fare_basis_code": faker.random.alpha(5),
            "flight_number": faker.random.alpha(5)
          },
          {
            "departure_date": "2018-02-01",
            "carrier_code": "2",
            "service_class": "3",
            "origin_city": faker.random.alpha(3),
            "destination_city": faker.random.alpha(3),
            "stopover_code": "2",
            "fare_basis_code": faker.random.alpha(5),
            "flight_number": faker.random.alpha(5)
          }
        ],
        taxes: [
          {
            "fee_amount": 1000,
            "fee_type": "Airport tax"
          },
          {
            "fee_amount": 1000,
            "fee_type": "Airport tax"
          }
        ]
      }
    })


  it 'works with ticket attributes', ->
    data = _.clone @data

    data = _.extend(data, {
      travel: {
        ticket: {
          "ticket_number": faker.datatype.number().toString(),
          "passenger_name": faker.random.alpha(12),
          "customer_code": "1",
          "restricted_ticket_indicator": 1,
          "agency_name": faker.random.alpha(6),
          "agency_code": faker.random.alpha(5),
          "confirmation_information": faker.random.alpha(12),
          "date_of_issue": "2018-02-01"
        }
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'works with legs attributes', ->
    data = _.clone @data
    data = _.extend(data, {
      travel: {
        legs: [
          {
            "departure_date": "2018-02-01",
            "carrier_code": "2",
            "service_class": "3",
            "origin_city": faker.random.alpha(3),
            "destination_city": faker.random.alpha(3),
            "stopover_code": "1",
            "fare_basis_code": faker.random.alpha(5),
            "flight_number": faker.random.alpha(5)
          },
          {
            "departure_date": "2018-02-01",
            "carrier_code": "2",
            "service_class": "3",
            "origin_city": faker.random.alpha(3),
            "destination_city": faker.random.alpha(3),
            "stopover_code": "2",
            "fare_basis_code": faker.random.alpha(5),
            "flight_number": faker.random.alpha(5)
          }
        ]
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'works with taxes attributes', ->
    data = _.clone @data
    data = _.extend(data, {
      travel: {
        taxes: [
          {
            "fee_amount": 1000,
            "fee_type": "Airport tax"
          },
          {
            "fee_amount": 1000,
            "fee_type": "Airport tax"
          }
        ]
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'works with valid charges type and sub_type', ->
    data = _.clone @data
    data = _.extend(data, {
      travel: {
        charges: {
          charge: {
            type: 'BG',
            sub_type: 'CF'
          }
        }
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'fails with invalid charges type', ->
    data = _.clone @data
    data = _.extend(data, {
      travel: {
        charges: {
          charge: {
            type: 'NOT_EXISTS'
          }
        }
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails with invalid charges sub_type', ->
    data = _.clone @data
    data = _.extend(data, {
      travel: {
        charges: {
          charge: {
            type: 'BF',
            sub_type: 'NOT_EXISTS'

          }
        }
      }
    })

    assert.equal false, @transaction.setData(data).isValid()


module.exports = TravelData
