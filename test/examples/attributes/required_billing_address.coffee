_ = require 'underscore'

RequiredBillingAddress = () ->

  it 'fails when missing billing_address', ->
    data = _.clone @data
    delete data.billing_address

    assert.isNotTrue @transaction.setData(data).isValid()

module.exports = RequiredBillingAddress


