_         = require 'underscore'
config    = require 'config'
util      = require 'util'

Currency  = require './currency'
Request   = require './request'


class Transaction

  constructor: () ->
    @currency  = new Currency
    @request   = new Request

  account_verification: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'account_verification'
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  avs: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'avs'
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  authorize: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success: onSuccess
        failure: onFailure
      trx:
        'payment_transation':
          _.extend params, {
            'transaction_type':
              'authorize'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  authorize3d: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transation':
          _.extend params, {
            'transaction_type':
              'authorize3d'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  blacklist: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'blacklist_request':
          params
      url:
        app:
          'gate'
        path:
          'blacklists'

    @request.send args

  capture: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'capture'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  chargeback: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'chargeback_request':
          params
      url:
        app:
          'gate'
        path:
          'chargebacks'

    @request.send args

  chargeback_by_date: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'chargeback_request':
          params
      url:
        app:
          'gate'
        path:
          'chargebacks/by_date'

    @request.send args

  credit: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'credit'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        path: 'process'
        app: 'gate'
        token: config.customer.token

    @request.send args

  fraud_report: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'fraud_report_request':
          params
      url:
        app:  'gate'
        path: 'fraud_reports'

    @request.send args

  fraud_report_by_date: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'fraud_report_request':
          params
      url:
        app:  'gate'
        path: 'fraud_reports/by_date'

    @request.send args
  init_recurring_sale: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'init_recurring_sale'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:  'gate'
        path: 'process'
        token: config.customer.token

    @request.send args

  init_recurring_sale3d: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'init_recurring_sale3d'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  reconcile: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'reconcile':
          params
      url:
        app:
          'gate'
        path:
          'reconcile'
        token:
          config.customer.token

    @request.send args

  reconcile_by_date: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'reconcile':
          params
      url:
        app:
          'gate'
        path:
          'reconcile/by_date'
        token:
          config.customer.token

    @request.send args

  recurring_sale: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'recurring_sale'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  refund: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'refund'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  retrieval: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'retrieval_request_request':
          params
      url:
        app:
          'gate'
        path:
          'retrieval_requests'

    @request.send args

  retrieval_by_date: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'retrieval_request_request':
          params
      url:
        app:
          'gate'
        path:
          'retrieval_requests/by_date'

    @request.send args

  payout: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'payout'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  sale: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'sale'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  sale3d: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'sale3d'
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  void: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'payment_transaction':
          _.extend params, {
            'transaction_type':
              'void'
          }
      url:
        app:
          'gate'
        path:
          'process'
        token:
          config.customer.token

    @request.send args

  wpf_create: (params, onSuccess, onFailure) ->

    # Locale
    if params.locale then locale = params.locale.slice 0, 2 else locale = 'en'

    delete params.locale

    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'wpf_payment':
          _.extend params, {
            # Convert the currency to ISO4217
            'amount':
              @currency.convertToMinorUnits params.amount, params.currency

            # Convert transaction_types from Array
            # to objects in order to apply them as
            # node attributes in the resulting XML
            'transaction_types':
              transaction_type:
                _.map params.transaction_types, (value) ->
                  return { "@": name: value.toString() }
          }
      url:
        app:
          'wpf'
        path:
          util.format '%s/wpf', locale

    @request.send args

  wpf_reconcile: (params, onSuccess, onFailure) ->
    args =
      callbacks:
        success:
          onSuccess
        failure:
          onFailure
      trx:
        'wpf_reconcile':
          params
      url:
        app:
          'wpf'
        path:
          'wpf/reconcile'

    @request.send args

module.exports = Transaction