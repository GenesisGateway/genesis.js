path = require('path');

TransactionTypes = require path.resolve './src/genesis/helpers/transaction/types'

describe 'TransactionTypes', ->

  before ->
    @transactionTypes = new TransactionTypes()

  it 'returns true when valid type is passed', ->
    assert.equal true, @transactionTypes.isValidType 'sale'

  it 'returns false when invalid type is passed', ->
    assert.equal false, @transactionTypes.isValidType 'not_valid_type'

  it 'returns true when valid WPF type is passed', ->
    assert.equal true, @transactionTypes.isValidWPFType 'sale'

  it 'returns false when invalid WPF type is passed', ->
    assert.equal false, @transactionTypes.isValidWPFType 'earthport'