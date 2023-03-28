faker = require 'faker'
_     = require 'underscore'

DynamicDescriptor = () ->

  it 'not fail with dinamic_descriptor_params', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_name": "Merchant123"
        "merchant_city": "Avaburgh"
        "sub_merchant_id": faker.datatype.number().toString()
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'not fail without dinamic_descriptor_params', ->
    data = _.clone @data
    delete data.dynamic_descriptor_params

    assert.equal true, @transaction.setData(data).isValid()

  it 'fail with more than 25 symbols in merchant_name', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_name": "Contain_more_than_twenty_four_symbols_in_merchant name"
        "merchant_city": faker.address.city()
        "sub_merchant_id": faker.datatype.number().toString()
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 13 symbols in merchant_city', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_name": "Merchant123"
        "merchant_city": "Contain_more_than_thirteen_symbols_in_the_merchant_city"
        "sub_merchant_id": faker.datatype.number().toString()
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 13 symbols in sub_merchant_id', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_name": "Merchant123"
        "merchant_city": "Avaburgh"
        "sub_merchant_id": "12345678910111213"
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

module.exports = DynamicDescriptor
