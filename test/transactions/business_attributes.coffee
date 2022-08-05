_        = require 'underscore'
FakeData = require './fake_data'

BusinessAttributes = () ->

  # flight_arrival_date
  it 'should fails when wrong flight_arrival_date format given', ->
    data = _.clone @data
    data['business_attributes']['flight_arrival_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of flight_arrival_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['flight_arrival_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of flight_arrival_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['flight_arrival_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right flight_arrival_date format given', ->
    data = _.clone @data
    data['business_attributes']['flight_arrival_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #flight_departure_date
  it 'should fails when wrong flight_departure_date format given', ->
    data = _.clone @data
    data['business_attributes']['flight_departure_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of flight_departure_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['flight_departure_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of flight_departure_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['flight_departure_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right flight_departure_date format given', ->
    data = _.clone @data
    data['business_attributes']['flight_departure_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #event_start_date
  it 'should fails when wrong event_start_date format given', ->
    data = _.clone @data
    data['business_attributes']['event_start_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of event_start_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['event_start_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of event_start_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['event_start_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right event_start_date format given', ->
    data = _.clone @data
    data['business_attributes']['event_start_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #event_start_date
  it 'should fails when wrong event_end_date format given', ->
    data = _.clone @data
    data['business_attributes']['event_end_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of event_end_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['event_end_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of event_end_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['event_end_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right event_end_date format given', ->
    data = _.clone @data
    data['business_attributes']['event_end_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #date_of_order
  it 'should fails when wrong date_of_order format given', ->
    data = _.clone @data
    data['business_attributes']['date_of_order'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of date_of_order is out of range', ->
    data = _.clone @data
    data['business_attributes']['date_of_order'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of date_of_order is out of range', ->
    data = _.clone @data
    data['business_attributes']['date_of_order'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right date_of_order format given', ->
    data = _.clone @data
    data['business_attributes']['date_of_order'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #delivery_date
  it 'should fails when wrong delivery_date format given', ->
    data = _.clone @data
    data['business_attributes']['delivery_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of delivery_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['delivery_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of delivery_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['delivery_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right delivery_date format given', ->
    data = _.clone @data
    data['business_attributes']['delivery_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #check_in_date
  it 'should fails when wrong check_in_date format given', ->
    data = _.clone @data
    data['business_attributes']['check_in_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of check_in_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['check_in_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of check_in_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['check_in_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right check_in_date format given', ->
    data = _.clone @data
    data['business_attributes']['check_in_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #check_out_date
  it 'should fails when wrong check_out_date format given', ->
    data = _.clone @data
    data['business_attributes']['check_out_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of check_out_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['check_out_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of check_out_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['check_out_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right check_out_date format given', ->
    data = _.clone @data
    data['business_attributes']['check_out_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #vehicle_pick_up_date
  it 'should fails when wrong vehicle_pick_up_date format given', ->
    data = _.clone @data
    data['business_attributes']['vehicle_pick_up_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of vehicle_pick_up_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['vehicle_pick_up_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of vehicle_pick_up_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['vehicle_pick_up_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right vehicle_pick_up_date format given', ->
    data = _.clone @data
    data['business_attributes']['vehicle_pick_up_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #vehicle_return_date
  it 'should fails when wrong vehicle_return_date format given', ->
    data = _.clone @data
    data['business_attributes']['vehicle_return_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of vehicle_return_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['vehicle_return_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of vehicle_return_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['vehicle_return_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right vehicle_return_date format given', ->
    data = _.clone @data
    data['business_attributes']['vehicle_return_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #cruise_start_date
  it 'should fails when wrong cruise_start_date format given', ->
    data = _.clone @data
    data['business_attributes']['cruise_start_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of cruise_start_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['cruise_start_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of cruise_start_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['cruise_start_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right cruise_start_date format given', ->
    data = _.clone @data
    data['business_attributes']['cruise_start_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #cruise_end_date
  it 'should fails when wrong cruise_end_date format given', ->
    data = _.clone @data
    data['business_attributes']['cruise_end_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of cruise_end_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['cruise_end_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of cruise_end_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['cruise_end_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right cruise_end_date format given', ->
    data = _.clone @data
    data['business_attributes']['cruise_end_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #arrival_date
  it 'should fails when wrong arrival_date format given', ->
    data = _.clone @data
    data['business_attributes']['arrival_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of arrival_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['arrival_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of arrival_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['arrival_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right arrival_date format given', ->
    data = _.clone @data
    data['business_attributes']['arrival_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #departure_date
  it 'should fails when wrong departure_date format given', ->
    data = _.clone @data
    data['business_attributes']['departure_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of departure_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['departure_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of departure_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['departure_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right departure_date format given', ->
    data = _.clone @data
    data['business_attributes']['departure_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #pick_up_date
  it 'should fails when wrong pick_up_date format given', ->
    data = _.clone @data
    data['business_attributes']['pick_up_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of pick_up_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['pick_up_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of pick_up_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['pick_up_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right pick_up_date format given', ->
    data = _.clone @data
    data['business_attributes']['pick_up_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  #return_date
  it 'should fails when wrong return_date format given', ->
    data = _.clone @data
    data['business_attributes']['return_date'] = '01/01/2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when day of return_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['return_date'] = '32-01-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should fails when month of return_date is out of range', ->
    data = _.clone @data
    data['business_attributes']['return_date'] = '31-13-2021'
    assert.equal false, @transaction.setData(data).isValid()

  it 'should not fails when right return_date format given', ->
    data = _.clone @data
    data['business_attributes']['return_date'] = '03-12-2021'
    assert.equal true, @transaction.setData(data).isValid()

  it 'fails with unsupported business attribute', ->
    data = (new FakeData).getSimpleDataAndBusinessAttributes()
    data['business_attributes']['INVALID'] = 'INVALID'
    assert.equal false, @transaction.setData(data).isValid()

  it 'fails with invalid payment type', ->
    data = (new FakeData).getSimpleDataAndBusinessAttributes()
    data['business_attributes']['payment_type'] = 'INVALID'
    assert.equal false, @transaction.setData(data).isValid()

  it 'not fails without business attributes', ->
    assert.equal true, @transaction.setData(_.omit(@data, 'business_attributes')).isValid()

module.exports = BusinessAttributes
