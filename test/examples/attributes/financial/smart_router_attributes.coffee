_     = require 'underscore'

SmartRouterAttributes = () ->
  describe 'Smart Router', ->
    beforeEach ->
      @skip() if @transaction.getTransactionType() == 'wpf_create'

      @data.use_smart_router = true
      @transaction.setData(@data)

    it 'works with smart router in request', ->
      assert.isTrue @transaction.isValid()

    it 'with proper endpoint', ->

      assert.equal(
        @transaction.formatUrl(@transaction.getArguments().url),
        "https://staging.api.#{@transaction.configuration.getGatewayHostname()}/transactions"
      )

    it 'when use_smart_router without request parameter', ->
      expect(@transaction.getArguments().trx.payment_transaction).to.not.have.nested.property('use_smart_router')

module.exports = SmartRouterAttributes
