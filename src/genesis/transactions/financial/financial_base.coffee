
Request          = require '../../request'
_                = require 'underscore'
ColorDepthHelper = require '../../helpers/color_depth'
JsonUtils        = require '../../utils/json_utils'

class FinancialBase extends Request

  constructor: (params, configuration) ->
    super params, configuration

    @formatThreedsV2ColorDepth()

  # Financial transactions endpoint
  getUrl: ->
    if @params.use_smart_router || @configuration.getCustomerForceSmartRouter()
      return app: 'smart_router', path: 'transactions'

    app: 'gate', path: 'process', token: @configuration.getCustomerToken()

  getTrxData: (outboundParams = @getOutboundParams()) ->
    # Remove use_smart_router from parameters sent to the gateway
    delete outboundParams.use_smart_router if outboundParams.use_smart_router

    @formatAmount(outboundParams)
    @formatManagedRecurringAmount(outboundParams)
    @formatMarketplaceDataAmount(outboundParams)

    'payment_transaction':
      _.extend(
        outboundParams,
        {
          'transaction_type':
            this.getTransactionType()
        }
    )

  getOutboundParams: ->
    outboundParams = _.clone @params

    if @params.travel
      outboundParams.travel = _.clone @params.travel
    if @params.managed_recurring
      outboundParams.managed_recurring = _.clone @params.managed_recurring
    if @params.marketplace_data
      outboundParams.marketplace_data = _.clone @params.marketplace_data

    outboundParams

  getData: () ->
    _.extend(
      {},
      @params,
      transaction_type: @getTransactionType()
    )

  # Format the Amount into minor units
  formatAmount: (outboundParams) ->
    # convert amount to minor units
    if outboundParams.amount and outboundParams.currency
      outboundParams.amount = @currency.convertToMinorUnits(
        outboundParams.amount, outboundParams.currency
      )

  # Format the Managed Recurring Amount into minor units
  formatManagedRecurringAmount: (outboundParams) ->
    if outboundParams.managed_recurring and outboundParams.currency
      if outboundParams.managed_recurring.amount
        outboundParams.managed_recurring.amount = @currency.convertToMinorUnits(
          outboundParams.managed_recurring.amount, outboundParams.currency
        )
      if outboundParams.managed_recurring.max_amount
        outboundParams.managed_recurring.max_amount = @currency.convertToMinorUnits(
          outboundParams.managed_recurring.max_amount, outboundParams.currency
        )

  # Format the Marketplace Data Amount into minor units
  formatMarketplaceDataAmount: (outboundParams) ->
    marketplaceData = outboundParams.marketplace_data

    if marketplaceData and outboundParams.currency and
        Object.prototype.hasOwnProperty.call(
          marketplaceData, 'foreign_retailer_transaction_amount'
        )
      marketplaceData.foreign_retailer_transaction_amount = @currency.convertToMinorUnits(
        marketplaceData.foreign_retailer_transaction_amount, outboundParams.currency
      )

  # Format Color Depth with correct value
  formatThreedsV2ColorDepth: ->
    if JsonUtils.isValidObjectChain(@params, 'threeds_v2_params.browser.color_depth')
      @params.threeds_v2_params.browser.color_depth = (new ColorDepthHelper).handleColorDepth(
        @params.threeds_v2_params.browser.color_depth
      ).toString()

module.exports = FinancialBase
