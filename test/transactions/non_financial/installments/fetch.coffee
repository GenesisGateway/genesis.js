Transaction  = require '../../../../src/genesis/transactions/non_financial/installments/fetch'
FakeConfig   = require '../../fake_config'
BaseExamples = require '../../base'
faker        = require 'faker'
Currency     = require '../../../../src/genesis/helpers/currency'

describe 'Installments Fetch API service', ->
  beforeEach ->
    @data        =
      amount:      faker.datatype.number()
      currency:    faker.random.arrayElement (new Currency).getCurrencies()
      card_number: faker.finance.creditCardNumber('visa')

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'when builds request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint', ->
      assert.equal @transaction.getUrl().path, 'v1/installments'

    it 'with proper builder interface', ->
      assert.equal @transaction.builderInterface, 'json'

  describe 'when invalid request', ->
    it 'with string amount', ->
      @data.amount = '1.23'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without amount', ->
      delete @data.amount

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without currency', ->
      delete @data.currency

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'with invalid currency', ->
      @data.currency = 'invalid'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without card_number', ->
      delete @data.card_number

      assert.isNotTrue @transaction.setData(@data).isValid()
