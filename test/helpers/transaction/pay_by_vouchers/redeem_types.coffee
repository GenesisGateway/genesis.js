path = require('path');

RedeemTypes = require path.resolve './src/genesis/helpers/transaction/pay_by_vouchers/redeem_types'

describe 'RedeemTypes', ->

  before ->
    @redeemTypes = new RedeemTypes()

  it 'returns array when redeem types are requested', ->
    assert.isArray @redeemTypes.getRedeemTypes()

  it 'returns false when invalid redeem type is passed', ->
    assert.equal false, @redeemTypes.isValidRedeemType 'not_valid_redeem_type'

