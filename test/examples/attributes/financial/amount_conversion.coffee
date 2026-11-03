_ = require 'underscore'

AmountConversion = () ->

  getConversionData = (data) ->
    conversionData = _.clone data
    conversionData.amount = 123.45
    conversionData.currency = 'EUR'

    conversionData

  describe 'Amount Conversion', ->

    it 'keeps string top-level amount input unchanged after formatting', ->
      data = getConversionData @data
      data.amount = '123.45'
      transaction = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      trx = transaction.getTrxData()
      expect(trx.payment_transaction.amount).to.equal '12345'
      expect(transaction.params.amount).to.equal '123.45'

    it 'keeps numeric top-level amount input unchanged after formatting', ->
      data = getConversionData @data
      transaction = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      trx = transaction.getTrxData()
      expect(trx.payment_transaction.amount).to.equal '12345'
      expect(transaction.params.amount).to.equal 123.45

    it 'converts the top-level amount identically on repeated builds', ->
      data = getConversionData @data
      transaction = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      firstTrx = transaction.getTrxData()
      secondTrx = transaction.getTrxData()
      firstArguments = transaction.getArguments()
      secondArguments = transaction.getArguments()
      firstXml = transaction.getRequestBody(firstArguments.trx)
      secondXml = transaction.getRequestBody(secondArguments.trx)

      for trx in [firstTrx, secondTrx, firstArguments.trx, secondArguments.trx]
        expect(trx.payment_transaction.amount).to.equal '12345'

      expect(firstXml).to.equal secondXml
      expect(firstXml).to.include '<amount>12345</amount>'
      expect(firstXml).to.not.include '<amount>1234500</amount>'
      expect(transaction.params).to.equal data
      expect(data.amount).to.equal 123.45

module.exports = AmountConversion
