faker = require 'faker'
_     = require 'underscore'

RiskParams = () ->

  it 'not fail with risk_params', ->
    data = _.clone @data
    risk_params = {
      "ssn": "987-65-4320",
      "mac_address": "12-34-56-78-9A-BC",
      "session_id": "1DA53551-5C60-498C-9C18-8456BDBA74A9",
      "user_id": "1002547",
      "user_level": "vip",
      "email": "test@example.com",
      "phone": "+49301234567",
      "remote_ip": "245.253.2.12",
      "serial_number": "",
      "pan_tail": "1234",
      "bin": "123456",
      "first_name": "John",
      "last_name": "Doe",
      "country": "USA",
      "pan": "123456789",
      "forwarded_ip": "245.128.1.1",
      "username": "test",
      "password": "123456",
      "bin_name": "THIS_IS_TEST",
      "bin_phone": "123456789"
    }

    data = _.extend(data, {"risk_params": risk_params})
    assert.equal true, @transaction.setData(data).isValid()


module.exports = RiskParams
