path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

DynamicDescriptor = require '../../../examples/attributes/financial/dynamic_descriptor'
FakeConfig        = require path.resolve './test/transactions/fake_config'
FakeData          = require '../../fake_data'
Transaction       = require path.resolve './src/genesis/transactions/financial/direct_debit/sdd_sale'
SDDBase           = require './sdd_base'

describe 'SddSale', ->

  SDDBase()
  DynamicDescriptor()

  beforeEach ->
    @data['iban'] = "DE09100100101234567891"
    @data['bic']  = "PBNKDEFFXXX"

    delete @data['customer_phone']
    delete @data['customer_email']

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  context 'with iban validation', ->

    context 'without iban', ->

      it 'is invalid', ->
        assert.isNotTrue @transaction.setData(_.omit @data, 'iban').isValid()

    context 'with wrong iban', ->

      it 'is invalid', ->
        data = _.clone @data
        data['iban'] = '123_NOT_VALID_IBAN'
        assert.isNotTrue @transaction.setData(data).isValid()

    context 'with bic validation', ->

      context 'without bic', ->

        it 'is valid', ->
          assert.isTrue @transaction.setData(_.omit @data, 'bic').isValid()

      context 'with wrong bic', ->

        it 'is invalid', ->
          data = _.clone @data
          data['bic'] = 'NOT_VALID_BIC'
          assert.isNotTrue @transaction.setData(data).isValid()

    context 'with country validation', ->

      context 'without country', ->

        it 'is invalid', ->
          data = _.clone @data
          data['billing_address'] = _.omit data['billing_address'], 'country'
          assert.isNotTrue @transaction.setData(data).isValid()

    context 'with first_name validation', ->

      context 'without first_name', ->

        it 'is invalid', ->
          data = _.clone @data
          data['billing_address'] = _.omit data['billing_address'], 'first_name'
          assert.isNotTrue @transaction.setData(data).isValid()

    context 'with last_name validation', ->

      context 'without last_name', ->

        it 'is invalid', ->
          data = _.clone @data
          data['billing_address'] = _.omit data['billing_address'], 'last_name'
          assert.isNotTrue @transaction.setData(data).isValid()

  context 'with valid request', ->

    it 'works with return, success and pending URLs', ->
      @data['return_success_url'] = faker.internet.url()
      @data['return_failure_url'] = faker.internet.url()
      @data['return_pending_url'] = faker.internet.url()

      assert.equal true, @transaction.setData(@data).isValid()

  context 'with dynamic descriptor merchant name', ->
    it 'fail with more than 140 symbols', ->
      data = _.clone @data
      data = _.extend(data, {
        dynamic_descriptor_params: {
          "merchant_name": faker.datatype.string(145)
        }
      })

      assert.isNotTrue @transaction.setData(data).isValid()
