path     = require 'path'
_        = require 'underscore'
Currency = require path.resolve './src/genesis/helpers/currency'

AmountConversion = () ->

  # Opt-in helper. It clones the suite's own @data and sets a deterministic,
  # valid (non-EUR, two-decimal) amount/currency it controls, then derives every
  # expected value from that clone via the Currency helper. The expected minor
  # unit is never a hard-coded literal.
  getConversionData = (data) ->
    conversionData = _.clone data
    conversionData.amount = 123.45
    conversionData.currency = 'USD'

    conversionData

  # Wrapper-agnostic amount accessor: FinancialBase suites use payment_transaction,
  # WPF uses wpf_payment.
  readAmount = (trx) ->
    if trx.payment_transaction then trx.payment_transaction.amount
    else if trx.wpf_payment then trx.wpf_payment.amount
    else undefined

  describe 'Amount Conversion', ->

    beforeEach ->
      @currencyHelper = new Currency

    it 'keeps string top-level amount input unchanged after formatting', ->
      data        = getConversionData @data
      data.amount = String data.amount
      inputAmount  = data.amount
      expectedMinor = @currencyHelper.convertToMinorUnits data.amount, data.currency
      transaction = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      trx = transaction.getTrxData()
      expect(readAmount(trx)).to.equal expectedMinor
      expect(transaction.params.amount).to.equal inputAmount
      expect(data.amount).to.equal inputAmount

    it 'keeps numeric top-level amount input unchanged after formatting', ->
      data          = getConversionData @data
      inputAmount   = data.amount
      expectedMinor = @currencyHelper.convertToMinorUnits data.amount, data.currency
      transaction   = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      trx = transaction.getTrxData()
      expect(readAmount(trx)).to.equal expectedMinor
      expect(transaction.params.amount).to.equal inputAmount
      expect(data.amount).to.equal inputAmount

    it 'converts the top-level amount identically on repeated builds', ->
      data          = getConversionData @data
      inputAmount   = data.amount
      expectedMinor = @currencyHelper.convertToMinorUnits data.amount, data.currency
      doubleMinor   = @currencyHelper.convertToMinorUnits expectedMinor, data.currency
      transaction   = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      firstTrx        = transaction.getTrxData()
      secondTrx       = transaction.getTrxData()
      firstArguments  = transaction.getArguments()
      secondArguments = transaction.getArguments()
      firstBody       = transaction.getRequestBody(firstArguments.trx)
      secondBody      = transaction.getRequestBody(secondArguments.trx)

      for trx in [firstTrx, secondTrx, firstArguments.trx, secondArguments.trx]
        expect(readAmount(trx)).to.equal expectedMinor

      expect(firstBody).to.equal secondBody
      expect(firstBody).to.include expectedMinor
      expect(firstBody).to.not.include doubleMinor
      expect(transaction.params.amount).to.equal inputAmount
      expect(data.amount).to.equal inputAmount

module.exports = AmountConversion
