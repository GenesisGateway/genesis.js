path = require('path')

PaymentMethods = require path.resolve './src/genesis/helpers/payment/methods'

describe 'PaymentMethods', ->

  before ->
    @paymentMethods = new PaymentMethods()

  it 'returns array when payment methods are requested', ->
    assert.isArray @paymentMethods.getMethods()

  it 'returns false when invalid payment method is passed', ->
    assert.equal false, @paymentMethods.isValidMethod 'not_valid_payment_method'

