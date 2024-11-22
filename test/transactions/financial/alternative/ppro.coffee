path  = require 'path'
_     = require 'underscore'
faker = require 'faker'

FakeData    = require '../../fake_data'
Transaction = require path.resolve './src/genesis/transactions/financial/alternative/ppro'

AlternativeBase = require './alternative_base'

describe 'PPRO Transaction', ->

  beforeEach ->
    @fakeData     = new FakeData
    @data        = @fakeData.getApmData()
    @transaction = new Transaction()

    _.extend(@data, @fakeData.getShippingData())
    @data['payment_type']               = 'my_bank'
    @data['billing_address']['country'] = 'IT'
    @data['currency']                   = 'EUR'
    @data['remote_ip']                  = faker.internet.ip()
    @data['return_success_url']         = faker.internet.url()
    @data['return_failure_url']         = faker.internet.url()
    @data['return_pending_url']         = faker.internet.url()

  describe 'when invalid request', ->
    it 'with invalid payment type', ->
      data = _.clone @data
      data['payment_type'] = 'INVALID_TYPE'

      assert.equal false, @transaction.setData(data).isValid()

    it 'with missing payment type', ->
      data = _.clone @data
      delete data['payment_type']

      assert.equal false, @transaction.setData(data).isValid()

  describe 'when valid request', ->
    it 'with bic attribute', ->
      data        = _.clone @data
      data['bic'] = 'GENODETT488'

      assert.equal true, @transaction.setData(data).isValid()

    it 'with iban attributes', ->
      data         = _.clone @data
      data['iban'] = 'DE07444488880123456789'

      assert.equal true, @transaction.setData(data).isValid()

  describe 'when my_bank payment type', ->
    beforeEach ->
      @data['payment_type']               = 'my_bank'
      @data['billing_address']['country'] = 'IT'
      @data['currency']                   = 'EUR'

    describe 'when invalid request', ->
      it 'with invalid currency', ->
        data = _.clone @data
        data['currency'] = 'USD'

        assert.equal false, @transaction.setData(data).isValid()

      it 'with invalid billing country', ->
        data = _.clone @data
        data['billing_address']['country'] = 'AT'

        assert.equal false, @transaction.setData(data).isValid()

    describe 'when valid request', ->
      it 'with valid attributes', ->
        assert.equal true, @transaction.setData(@data).isValid()

  describe 'when eps payment type', ->
    beforeEach ->
      @data['payment_type']               = 'eps'
      @data['billing_address']['country'] = 'AT'
      @data['currency']                   = 'EUR'

    describe 'when invalid request', ->
      it 'with invalid currency', ->
        data = _.clone @data
        data['currency'] = 'USD'

        assert.equal false, @transaction.setData(data).isValid()

      it 'with invalid billing country', ->
        data = _.clone @data
        data['billing_address']['country'] = 'IT'

        assert.equal false, @transaction.setData(data).isValid()

    describe 'when valid request', ->
      it 'with valid attributes', ->
        assert.equal true, @transaction.setData(@data).isValid()

  describe 'when bancontact payment type', ->
    beforeEach ->
      @data['payment_type']               = 'bcmc'
      @data['billing_address']['country'] = 'BE'
      @data['currency']                   = 'EUR'

    describe 'when invalid request', ->
      it 'with invalid currency', ->
        data = _.clone @data
        data['currency'] = 'USD'

        assert.equal false, @transaction.setData(data).isValid()

      it 'with invalid billing country', ->
        data = _.clone @data
        data['billing_address']['country'] = 'IT'

        assert.equal false, @transaction.setData(data).isValid()

    describe 'when valid request', ->
      it 'with valid attributes', ->
        assert.equal true, @transaction.setData(@data).isValid()

  describe 'when safetypay payment type', ->
    beforeEach ->
      @data['payment_type']               = 'safetypay'
      @data['billing_address']['country'] = 'AT'
      @data['currency']                   = 'EUR'

    describe 'when invalid request', ->
      it 'with invalid currency', ->
        data = _.clone @data
        data['currency'] = 'BGN'

        assert.equal false, @transaction.setData(data).isValid()

      it 'with invalid billing country', ->
        data = _.clone @data
        data['billing_address']['country'] = 'IT'

        assert.equal false, @transaction.setData(data).isValid()

    describe 'when valid request', ->
      it 'with valid attributes', ->
        assert.equal true, @transaction.setData(@data).isValid()

  AlternativeBase()


