
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

  getTrxData: ->
    # Remove use_smart_router from parameters sent to the gateway
    delete @params.use_smart_router if @params.use_smart_router

    @formatAmount()
    @formatManagedRecurringAmount()

    'payment_transaction':
      _.extend(
        @params,
        {
          'transaction_type':
            this.getTransactionType()
        }
    )

  getData: () ->
    _.extend(
      {},
      @params,
      transaction_type: @getTransactionType()
    )

  # Format the Amount into minor units
  formatAmount: ->
    # convert amount to minor units
    if @params.amount and @params.currency
      @params.amount = @currency.convertToMinorUnits @params.amount, @params.currency

  # Format the Managed Recurring Amount into minor units
  formatManagedRecurringAmount: ->
    if @params.managed_recurring and @params.currency
      if @params.managed_recurring.amount
        @params.managed_recurring.amount = @currency.convertToMinorUnits(
          @params.managed_recurring.amount, @params.currency
        )
      if @params.managed_recurring.max_amount
        @params.managed_recurring.max_amount = @currency.convertToMinorUnits(
          @params.managed_recurring.max_amount, @params.currency
        )

  # Format Color Depth with correct value
  formatThreedsV2ColorDepth: ->
    if JsonUtils.isValidObjectChain(@params, 'threeds_v2_params.browser.color_depth')
      @params.threeds_v2_params.browser.color_depth = (new ColorDepthHelper).handleColorDepth(
        @params.threeds_v2_params.browser.color_depth
      ).toString()

module.exports = FinancialBase
