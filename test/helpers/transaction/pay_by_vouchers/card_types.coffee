path = require('path');

CardTypes = require path.resolve './src/genesis/helpers/transaction/pay_by_vouchers/card_types'

describe 'CardTypes', ->

  before ->
    @cardTypes = new CardTypes()

  it 'returns array when card types are requested', ->
    assert.isArray @cardTypes.getCardTypes()

  it 'returns false when invalid card type is passed', ->
    assert.equal false, @cardTypes.isValidCardType 'not_valid_card_type'

