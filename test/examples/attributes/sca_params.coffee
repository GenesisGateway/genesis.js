faker = require 'faker'
_     = require 'underscore'

ScaParams = () ->

  it 'not fail with sca_params', ->
    data = _.clone @data
    sca_params = {
      "exemption": "low_risk",
      "visa_merchant_id": faker.datatype.number().toString()
    }
    data = _.extend(data, {"sca_params": sca_params})
    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with invalid sca exemption', ->
    data = _.clone @data
    sca_params = {
      "exemption": "INVALID",
      "visa_merchant_id": faker.datatype.number().toString()
    }
    data = _.extend(data, {"sca_params": sca_params})
    assert.equal false, @transaction.setData(data).isValid()

module.exports = ScaParams
