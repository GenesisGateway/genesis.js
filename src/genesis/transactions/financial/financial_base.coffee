
Base                 = require '../base'
_                    = require 'underscore'
config               = require 'config'
ColorDepth           = require '../../helpers/color_depth'
JsonUtils            = require '../../utils/json_utils'
SmartRouter          = require '../../helpers/smart_router'

class FinancialBase extends Base

  constructor: (params, configuration) ->
    super params, configuration
    @configuration = configuration

    @smartRouterParams      = (new SmartRouter).getSmartRouterUrlParams()

    if JsonUtils.isValidObjectChain(params, 'threeds_v2_params.browser.color_depth')
      @params.threeds_v2_params.browser.color_depth =
        (new ColorDepth).handleColorDepth(params.threeds_v2_params.browser.color_depth).toString()

  getUrl: ->
    if @params.use_smart_router || @configuration.getCustomerForceSmartRouter()
      return @smartRouterParams

    app:
      'gate'
    path:
      'process'
    token:
      @configuration.getCustomerToken()

  getTrxData: ->

    # convert amount to minor units
    if @params.amount and @params.currency
      @params.amount = @currency.convertToMinorUnits @params.amount, @params.currency

    if @params.managed_recurring and @params.currency
      if @params.managed_recurring.amount
        @params.managed_recurring.amount = @currency.convertToMinorUnits(
          @params.managed_recurring.amount, @params.currency
        )
      if @params.managed_recurring.max_amount
        @params.managed_recurring.max_amount = @currency.convertToMinorUnits(
          @params.managed_recurring.max_amount, @params.currency
        )

    'payment_transaction':
      _.extend(
        @params,
        {
          'transaction_type':
           this.getTransactionType()
        }
    )

module.exports = FinancialBase
