_        = require 'underscore'
FakeData = require '../../../transactions/fake_data'

MarketplaceData = () ->

  getConversionData = (data) ->
    conversionData = _.clone data
    conversionData.amount = 123.45
    conversionData.currency = 'EUR'
    conversionData.marketplace_data =
      foreign_retailer_indicator: 'F'
      foreign_retailer_transaction_amount: 40.5

    conversionData

  describe 'Marketplace Data', ->
    beforeEach ->
      @marketplaceData = _.clone @data
      @marketplaceData = _.extend @marketplaceData, (new FakeData).getMarketplaceData()

    it 'works with both indicator and amount', ->
      assert.isTrue @transaction.setData(@marketplaceData).isValid()

    it 'works with only foreign_retailer_indicator', ->
      delete @marketplaceData.marketplace_data.foreign_retailer_transaction_amount

      assert.isTrue @transaction.setData(@marketplaceData).isValid()

    it 'fail when amount is present without indicator', ->
      delete @marketplaceData.marketplace_data.foreign_retailer_indicator

      assert.isNotTrue @transaction.setData(@marketplaceData).isValid()

    it 'fail when foreign_retailer_indicator is not F', ->
      @marketplaceData.marketplace_data.foreign_retailer_indicator = 'X'

      assert.isNotTrue @transaction.setData(@marketplaceData).isValid()

    it 'accepts a decimal numeric foreign retailer amount before serialization', ->
      data = getConversionData @data
      transaction = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      marketplaceData = transaction.params.marketplace_data
      expect(marketplaceData.foreign_retailer_transaction_amount).to.equal 40.5

    it 'rejects a numeric-looking string foreign retailer amount', ->
      data = getConversionData @data
      data.marketplace_data.foreign_retailer_transaction_amount = '40.5'

      expect(@transaction.setData(data).isValid()).to.equal false

    it 'fail when marketplace_data node with additional properties', ->
      @marketplaceData.marketplace_data.element = 'value'

      assert.isNotTrue @transaction.setData(@marketplaceData).isValid()

    it 'formats a decimal foreign retailer amount in outbound data and XML', ->
      data = getConversionData @data
      transaction = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      trx = transaction.getTrxData()
      marketplaceData = trx.payment_transaction.marketplace_data
      expect(marketplaceData.foreign_retailer_transaction_amount).to.equal '4050'

      xml = transaction.getRequestBody(trx)
      expect(xml).to.include(
        '<foreign_retailer_transaction_amount>4050</foreign_retailer_transaction_amount>'
      )

    it 'formats a zero foreign retailer amount in outbound data', ->
      data = getConversionData @data
      data.marketplace_data.foreign_retailer_transaction_amount = 0
      transaction = @transaction.setData(data)

      expect(transaction.isValid()).to.equal true
      trx = transaction.getTrxData()
      marketplaceData = trx.payment_transaction.marketplace_data
      expect(marketplaceData.foreign_retailer_transaction_amount).to.equal '0'
      expect(transaction.params.marketplace_data.foreign_retailer_transaction_amount).to.equal 0

    it 'builds identical outbound data without changing original amounts', ->
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
        paymentTransaction = trx.payment_transaction
        expect(paymentTransaction.marketplace_data.foreign_retailer_transaction_amount)
          .to.equal '4050'

      expect(firstXml).to.equal secondXml
      expect(transaction.params).to.equal data
      expect(data.marketplace_data.foreign_retailer_transaction_amount).to.equal 40.5

    it 'sends the preview body without converting amounts twice', ->
      data = getConversionData @data
      transaction = @transaction.setData(data)
      preview = transaction.getRequestBody(transaction.getArguments().trx)
      networkSend = sinon.stub(transaction.network, 'send').resolves('Gateway Response')

      transaction.send()
        .then (response) ->
          expect(response).to.equal 'Gateway Response'
          expect(networkSend).to.have.been.calledOnce
          sentBody = networkSend.firstCall.args[1]
          expect(sentBody).to.equal preview
          expect(sentBody).to.include(
            '<foreign_retailer_transaction_amount>4050</foreign_retailer_transaction_amount>'
          )
          expect(sentBody).to.not.include(
            '<foreign_retailer_transaction_amount>405000</foreign_retailer_transaction_amount>'
          )
        .finally ->
          networkSend.restore()

module.exports = MarketplaceData
