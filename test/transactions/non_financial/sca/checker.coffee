Transaction  = require '../../../../src/genesis/transactions/non_financial/sca/checker'
FakeConfig   = require '../../fake_config'
faker        = require 'faker'
BaseExamples = require '../../base'

describe 'SCA Checker request', ->
  beforeEach ->
    @data =
      card_number: '4111112232423922',
      transaction_amount: '0.99',
      transaction_currency: 'EUR',
      moto: false,
      mit: false,
      recurring_type: faker.random.arrayElement(['initial', 'subsequent']),
      transaction_exemption: faker.random.arrayElement(['', 'low_value', 'low_risk', 'trusted_merchant', 'corporate_payment', 'auth_network_outage'])

    @transaction = new Transaction(@data, FakeConfig.getConfig())

  BaseExamples()

  describe 'when valid request', ->
    it 'with all supported params', ->
      assert.isTrue @transaction.isValid()

    it 'with minimum required parameters', ->
      delete @data.moto
      delete @data.mit
      delete @data.recurring_type
      delete @data.transaction_exemption

      assert.isTrue @transaction.setData(@data).isValid()

    it 'when card_number with minimum allowed symbols', ->
      @data.card_number = '000000'

      assert.isTrue @transaction.setData(@data).isValid()

    it 'when card_number with maximum allowed symbols', ->
      @data.card_number = '0000000000000000000'

      assert.isTrue @transaction.setData(@data).isValid()

    it 'when transaction_amount with minor unit conversion', ->
      assert.equal @transaction.getArguments().trx.transaction_amount, 99

    it 'when transaction_amount with non-string value', ->
      @data.transaction_amount = 0.99

      assert.equal @transaction.getArguments().trx.transaction_amount, 99

    it 'when transaction_amount with Number data type sent to the gateway', ->
      assert.isNumber @transaction.getArguments().trx.transaction_amount

  describe 'when invalid request', ->
    it 'without card_number', ->
      delete @data.card_number

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'when card_number with minimum invalid symbols', ->
      @data.card_number = '00000'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'when card_number with maximum invalid symbols', ->
      @data.card_number = '00000000000000000000'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without transaction_amount', ->
      delete @data.transaction_amount

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'when transaction_amount with invalid value', ->
      @data.transaction_amount = '1,99'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'without transaction_currency', ->
      delete @data.transaction_currency

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'when moto with non-boolean value', ->
      @data.moto = 'false'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'when mit with non-boolean value', ->
      @data.mit = 'false'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'when recurring_type with invalid value', ->
      @data.recurirng_type = 'invalid'

      assert.isNotTrue @transaction.setData(@data).isValid()

    it 'when transaction_exemption with invalid value', ->
      @data.transaction_exemption = 'delegated_authentication'

      assert.isNotTrue @transaction.setData(@data).isValid()
