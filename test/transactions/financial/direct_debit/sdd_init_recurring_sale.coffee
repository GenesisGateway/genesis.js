path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData      = require '../../fake_data'
SDDBase       = require './sdd_base'
Transaction   =
  require path.resolve './src/genesis/transactions/financial/direct_debit/sdd_init_recurring_sale'

describe 'SddInitRecurringSale', ->

  SDDBase()

  before ->
    @data['iban'] = "DE09100100101234567891"
    @data['bic']  = "PBNKDEFFXXX"

    @transaction = new Transaction()

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

  context 'with billing_address.country validation', ->

    it 'is invalid', ->
      data = _.clone @data
      data['billing_address']['country'] = 'BG'
      assert.isNotTrue @transaction.setData(data).isValid()
