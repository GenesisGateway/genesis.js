faker    = require 'faker'
_        = require 'underscore'
FakeData = require '../../../../transactions/fake_data'

TravelData = () ->

  describe 'Level 3 Travel Data Attributes', ->
    beforeEach ->
      @fakeData = new FakeData

      @travelData = _.clone @data
      @travelData = _.extend(@travelData, @fakeData.getLevel3TravelData())

    it 'with all attributes', ->
      assert.isTrue @transaction.setData(@travelData).isValid()

    it 'with additional properties', ->
      @travelData.travel.element = 'value'

      assert.isNotTrue @transaction.setData(@travelData).isValid()

    describe 'Ticket Attributes', ->
      it 'without additional attributes', ->
        @travelData.travel.ticket.element = 'value'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when ticket_number with invalid value', ->
        @travelData.travel.ticket.ticket_number = faker.random.alpha(16)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when passenger_name with invalid value', ->
        @travelData.travel.ticket.passenger_name = faker.random.alpha(30)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when customer_code with invalid value', ->
        @travelData.travel.ticket.customer_code = faker.random.alpha(18)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when issuing_carrier with invalid value', ->
        @travelData.travel.ticket.issuing_carrier = faker.random.alpha(5)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when total_fare with invalid string value', ->
        @travelData.travel.ticket.total_fare = '1'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when total_fare with invalid number value', ->
        @travelData.travel.ticket.total_fare = 1.99

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when agency_name with invalid value', ->
        @travelData.travel.ticket.agency_name = faker.random.alpha(31)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when agency_code with invalid value', ->
        @travelData.travel.ticket.agency_code = faker.random.alpha(9)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when confirmation_information with invalid value', ->
        @travelData.travel.ticket.confirmation_information = faker.random.alpha(475)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when date_of_issue with invalid value', ->
        @travelData.travel.ticket.date_of_issue = faker.random.alpha(11)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when restricted_ticket_indicator with empty value', ->
        @travelData.travel.ticket.restricted_ticket_indicator = ''

        assert.isTrue @transaction.setData(@travelData).isValid()

      it 'when restricted_ticket_indicator with invalid value', ->
        @travelData.travel.ticket.restricted_ticket_indicator = '2'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when ticket_reference_id with invalid value', ->
        @travelData.travel.ticket.ticket_reference_id = faker.random.alpha(33)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when ticket_document_number with invalid value', ->
        @travelData.travel.ticket.ticket_document_number = faker.random.alpha(16)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when issued_with_ticket_number with invalid value', ->
        @travelData.travel.ticket.issued_with_ticket_number = faker.random.alpha(16)

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'with additional properties', ->
        @travelData.travel.ticket.element = 'value'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

    describe 'Legs attributes', ->
      beforeEach ->
        @legData = @fakeData.getLevel3TravelLegData()

      it 'with valid data', ->
        @travelData.travel.legs.leg = [@legData]

        assert.isTrue @transaction.setData(@travelData).isValid()

      it 'with additional properties', ->
        @travelData.travel.legs.element = 'value'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with empty data', ->
        @travelData.travel.legs.leg = {}

        assert.isTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid non array data type', ->
        @travelData.travel.legs.leg = @legData

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with additional properties', ->
        @legData = _.extend @legData, { element: 'value' }

        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid max items count', ->
        @travelData.travel.legs.leg = []
        @travelData.travel.legs.leg.push @legData for item in [0..10]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid departure_date', ->
        @legData.departure_date     = faker.random.alpha(11)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid arrival_date', ->
        @legData.arrival_date       = faker.random.alpha(11)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid carrier_code', ->
        @legData.carrier_code       = faker.random.alpha(3)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid service_class', ->
        @legData.service_class      = faker.random.alpha(2)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid origin_city', ->
        @legData.origin_city        = faker.random.alpha(4)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid destination_city', ->
        @legData.destination_city   = faker.random.alpha(4)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid stopover_code', ->
        @legData.stopover_code      = '0'
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid fare_basis_code', ->
        @legData.fare_basis_code    = faker.random.alpha(7)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid flight_number', ->
        @legData.flight_number      = faker.random.alpha(6)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid departure_time', ->
        @legData.departure_time     = faker.random.alpha(6)
        @travelData.travel.legs.leg = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when leg with invalid departure_time_segment', ->
        @legData.departure_time_segment = "B"
        @travelData.travel.legs.leg     = [@legData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

    describe 'Taxes attributes', ->
      beforeEach ->
        @taxData = @fakeData.getLevel3TravelTaxData()

      it 'with valid data', ->
        @travelData.travel.taxes.tax = [@taxData]

        assert.isTrue @transaction.setData(@travelData).isValid()

      it 'with additional properties', ->
        @travelData.travel.taxes.element = 'value'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when tax with empty data', ->
        @travelData.travel.taxes.tax = {}

        assert.isTrue @transaction.setData(@travelData).isValid()

      it 'when tax with invalid non array data type', ->
        @travelData.travel.taxes.tax = @taxData

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when tax with additional properties', ->
        @taxData = _.extend @taxData, { element: 'value' }

        @travelData.travel.taxes.tax = [@taxData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when tax with invalid max items count', ->
        @travelData.travel.taxes.tax = []
        @travelData.travel.taxes.tax.push @taxData for item in [0..10]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when tax with invalid fee_amount string value', ->
        @taxData.fee_amount          = '1'
        @travelData.travel.taxes.tax = [@taxData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when tax with invalid fee_amount number value', ->
        @taxData.fee_amount          = 1.99
        @travelData.travel.taxes.tax = [@taxData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when tax with invalid fee_type value', ->
        @taxData.fee_type            = faker.random.alpha(9)
        @travelData.travel.taxes.tax = [@taxData]

        assert.isNotTrue @transaction.setData(@travelData).isValid()

    describe 'Rentals attributes', ->
      it 'with additional properties', ->
        @travelData.travel.rentals.element = 'value'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      describe 'Car Rental attributes', ->
        it 'with additional properties', ->
          @travelData.travel.rentals.car_rental.element = 'value'

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid purchase identifier', ->
          @travelData.travel.rentals.car_rental.purchase_identifier = faker.random.alpha(10)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid class_id', ->
          @travelData.travel.rentals.car_rental.class_id = "0"

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid pickup_date', ->
          @travelData.travel.rentals.car_rental.puckup_date = faker.random.alpha(11)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid renter_name', ->
          @travelData.travel.rentals.car_rental.renter_name = faker.random.alpha(21)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid return_city', ->
          @travelData.travel.rentals.car_rental.return_city = faker.random.alpha(19)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid return_state', ->
          @travelData.travel.rentals.car_rental.return_state = faker.random.alpha(4)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid return_country', ->
          @travelData.travel.rentals.car_rental.return_country = faker.random.alpha(4)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid return_date', ->
          @travelData.travel.rentals.car_rental.return_date = faker.random.alpha(11)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid renter_return_location_id', ->
          @travelData.travel.rentals.car_rental.renter_return_location_id = faker.random.alpha(11)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'with invalid customer_code', ->
          @travelData.travel.rentals.car_rental.customer_code = faker.random.alpha(18)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with invalid datatype', ->
          @travelData.travel.rentals.car_rental.extra_charges = 'value'

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with multiple values', ->
          @travelData.travel.rentals.car_rental.extra_charges = [1,2]

          assert.isTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with invalid value', ->
          @travelData.travel.rentals.car_rental.extra_charges = [0]

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with invalid max items', ->
          charges = [1,2,3,4,5]
          @travelData.travel.rentals.car_rental.extra_charges = []

          for item in [0..5]
            @travelData.travel.rentals.car_rental.extra_charges.push _.sample(charges)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when no_show_indicator with invalid value', ->
          @travelData.travel.rentals.car_rental.no_show_indicator = '2'

          assert.isNotTrue @transaction.setData(@travelData).isValid()

      describe 'Hotel Rental attributes', ->
        it 'with additional properties', ->
          @travelData.travel.rentals.hotel_rental.element = 'value'

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when purchase_identifier with invalid value', ->
          @travelData.travel.rentals.hotel_rental.purchase_identifier = faker.random.alpha(11)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when arrival_date with invalid value', ->
          @travelData.travel.rentals.hotel_rental.arrival_date = faker.random.alpha(11)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when departure_date with invalid value', ->
          @travelData.travel.rentals.hotel_rental.departure_date = faker.random.alpha(11)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when customer_code with invalid value', ->
          @travelData.travel.rentals.hotel_rental.customer_code = faker.random.alpha(18)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with invalid datatype', ->
          @travelData.travel.rentals.hotel_rental.extra_charges = 'value'

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with multiple values', ->
          @travelData.travel.rentals.hotel_rental.extra_charges = [2,3]

          assert.isTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with invalid value', ->
          @travelData.travel.rentals.hotel_rental.extra_charges = [0]

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when extra_charges with invalid max items', ->
          charges                                               = [2, 3, 4, 5, 6, 7]
          @travelData.travel.rentals.hotel_rental.extra_charges = []

          for item in [0..6]
            @travelData.travel.rentals.hotel_rental.extra_charges.push _.sample(charges)

          assert.isNotTrue @transaction.setData(@travelData).isValid()

        it 'when no_show_indicator with invalid value', ->
          @travelData.travel.rentals.hotel_rental.no_show_indicator = '2'

          assert.isNotTrue @transaction.setData(@travelData).isValid()

    describe 'Charges attributes', ->
      it 'with additional properties', ->
        @travelData.travel.charges.element = 'value'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when charge with additional properties', ->
        @travelData.travel.charges.charge.element = 'value'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when charge with invalid type', ->
        @travelData.travel.charges.charge.type = 'invalid'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

      it 'when charge with invalid sub_type', ->
        @travelData.travel.charges.charge.sub_type = 'invalid'

        assert.isNotTrue @transaction.setData(@travelData).isValid()

module.exports = TravelData
