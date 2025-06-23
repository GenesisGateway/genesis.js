faker                         = require 'faker'
path                          = require 'path'
_                             = require 'underscore'
Currency                      = require path.resolve './src/genesis/helpers/currency'
DynamicDescriptor             = require '../../../examples/attributes/financial/dynamic_descriptor'
DynamicDescriptorMerchantName =
  require '../../../examples/attributes/financial/dynamic_descriptor_merchant_name'
FakeConfig                    = require path.resolve './test/transactions/fake_config'
FakeData                      = require '../../fake_data'
FinancialExamples             = require '../financial_base'
GiftCardAttributes            =
  require '../../../examples/attributes/financial/gift_card_attributes'
Transaction                   =
  require path.resolve './src/genesis/transactions/financial/gift_cards/fashioncheque'

describe 'Fashioncheque Transaction', ->

  beforeEach ->
    fakeData     = new FakeData()
    @transaction = new Transaction(@data, FakeConfig.getConfig())

    @data                  = fakeData.getMinimumData()
    @data.currency         = faker.random.arrayElement (new Currency).getCurrencies()
    @data.amount           = faker.datatype.number().toString()
    @data.card_number      = '1234567890987654321'
    @data.cvv              = '12345'
    @data.token            = faker.random.alpha(36) 
    @data.billing_address  = fakeData.getBillingData().billing_address
    @data.shipping_address = fakeData.getShippingData().shipping_address

  DynamicDescriptor()
  DynamicDescriptorMerchantName()
  FinancialExamples()
  GiftCardAttributes()
