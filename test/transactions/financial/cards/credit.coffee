path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

AccountOwnerAttributes = require '../../../examples/attributes/financial/account_owner_attributes'
Crypto                 = require '../../../examples/attributes/financial/crypto'
DigitalAssetTypes      = require '../../../examples/attributes/digital_asset_types'
FakeConfig             = require path.resolve './test/transactions/fake_config'
FakeData               = require '../../fake_data'
FinancialBase          = require '../financial_base'
Transaction            = require path.resolve './src/genesis/transactions/financial/cards/credit'
PurposeOfPayment       = require '../../../examples/attributes/financial/purpose_of_payment'

describe 'Credit Transaction', ->

  before ->
    @data        = (new FakeData).getSimpleData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    delete @data['customer_phone']
    delete @data['customer_email']

    @data['reference_id'] = faker.datatype.number().toString()

  FinancialBase()

  it 'fails when missing required reference_id parameter', ->
    assert.equal false, @transaction.setData(_.omit @data, 'reference_id').isValid()

  it 'fails when wrong source_of_funds parameter value given', ->
    data = _.clone @data
    data.source_of_funds = 'NOT_VALID_VALUE'
    assert.equal false, @transaction.setData(data).isValid()

  Crypto()
  DigitalAssetTypes()
  AccountOwnerAttributes()
  PurposeOfPayment()
