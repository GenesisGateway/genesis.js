faker = require 'faker'
_     = require 'underscore'

DynamicDescriptorMerchantName = () ->

  it 'fail with more than 25 symbols in merchant_name', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_name": "Contain_more_than_twenty_four_symbols_in_merchant name"
        "merchant_city": faker.address.city()
        "sub_merchant_id": faker.datatype.number().toString()
      }
    })

    assert.isNotTrue @transaction.setData(data).isValid()

module.exports = DynamicDescriptorMerchantName
