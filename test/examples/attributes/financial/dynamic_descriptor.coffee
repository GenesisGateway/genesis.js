faker = require 'faker'
_     = require 'underscore'

DynamicDescriptor = () ->

  it 'works with dynamic_descriptor_params', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_name": "Merchant123"
        "merchant_city": "Avaburgh"
        "sub_merchant_id": faker.datatype.number().toString()
        "merchant_country": faker.random.alpha(3)
        "merchant_state": faker.random.alpha(3)
        "merchant_zip_code": faker.random.alpha(10)
        "merchant_address": faker.random.alpha(48)
        "merchant_url": faker.random.alpha(60)
        "merchant_phone": faker.random.alpha(16)
        "merchant_service_city": faker.random.alpha(13)
        "merchant_service_country": faker.random.alpha(3)
        "merchant_service_state": faker.random.alpha(3)
        "merchant_service_zip_code": faker.random.alpha(10)
        "merchant_service_phone": faker.random.alpha(16)
      }
    })

    assert.equal true, @transaction.setData(data).isValid()

  it 'works without dynamic_descriptor_params', ->
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

  it 'fail with more than 3 symbols in merchant_country', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_country": faker.random.alpha(4)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 3 symbols in merchant_state', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_state": faker.random.alpha(4)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 10 symbols in merchant_zip_code', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_zip_code": faker.random.alpha(11)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 48 symbols in merchant_address', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_address": faker.random.alpha(49)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 60 symbols in merchant_url', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_url": faker.random.alpha(61)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 16 symbols in merchant_phone', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_phone": faker.random.alpha(18)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 13 symbols in merchant_service_city', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_service_city": faker.random.alpha(14)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 3 symbols in merchant_service_country', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_service_country": faker.random.alpha(4)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 3 symbols in merchant_service_state', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_service_state": faker.random.alpha(7)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 10 symbols in merchant_service_zip_code', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_service_zip_code": faker.random.alpha(13)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

  it 'fail with more than 16 symbols in merchant_service_phone', ->
    data = _.clone @data
    data = _.extend(data, {
      dynamic_descriptor_params: {
        "merchant_service_phone": faker.random.alpha(20)
      }
    })

    assert.equal false, @transaction.setData(data).isValid()

module.exports = DynamicDescriptor
