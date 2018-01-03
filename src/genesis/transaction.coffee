
###
  Financial transactions
###
Authorize           = require './transactions/financial/cards/authorize'
Authorize3d         = require './transactions/financial/cards/authorize3d'
Sale                = require './transactions/financial/cards/sale'
Sale3d              = require './transactions/financial/cards/sale3d'
Cancel              = require './transactions/financial/cancel'
Payout              = require './transactions/financial/cards/payout'
Credit              = require './transactions/financial/cards/credit'
RecurringSale       = require './transactions/financial/cards/recurring/recurring_sale'
InitRecurringSale   = require './transactions/financial/cards/recurring/init_recurring_sale'
InitRecurringSale3d = require './transactions/financial/cards/recurring/init_recurring_sale3d'
Capture             = require './transactions/financial/capture'
Refund              = require './transactions/financial/refund'

###
  Non Financial transactions
###
AccountVerification = require './transactions/non_financial/account_verification'
Chargeback          = require './transactions/non_financial/fraud/chargeback/chargeback'
ChargebackByDate    = require './transactions/non_financial/fraud/chargeback/chargeback_by_date'
Blacklist           = require './transactions/non_financial/blacklist'
FraudReport         = require './transactions/non_financial/fraud/reports/fraud_report'
FraudReportByDate   = require './transactions/non_financial/fraud/reports/fraud_report_by_date'
Retrieval           = require './transactions/non_financial/fraud/retrieval/retrieval'
RetrievalByDate     = require './transactions/non_financial/fraud/retrieval/retrieval_by_date'
Reconcile           = require './transactions/non_financial/reconcile/reconcile'
ReconcileByDate     = require './transactions/non_financial/reconcile/reconcile_by_date'
Avs                 = require './transactions/non_financial/avs'

###
  Web Payment Form
###
WpfCreate           = require './transactions/wpf/create'
WpfReconcile        = require './transactions/wpf/reconcile'


###
  Financial Alternative transactions
###
P24                 = require './transactions/financial/alternative/p24'
PaypalExpress       = require './transactions/financial/alternative/paypal_express'
Paysafecard         = require './transactions/financial/alternative/paysafecard'
Sofort              = require './transactions/financial/alternative/sofort'
PPRO                = require './transactions/financial/alternative/ppro'

###
  Financial OBP transactions
###
PaySecPayin         = require './transactions/financial/obp/paysec/payin'
PaySecPayout        = require './transactions/financial/obp/paysec/payout'

class Transaction

  ###
    Non Financial transactions
  ###
  account_verification: (params, onSuccess, onFailure) ->
    new AccountVerification(params).send(onSuccess, onFailure)

  blacklist: (params, onSuccess, onFailure) ->
    new Blacklist(params).send(onSuccess, onFailure)

  chargeback: (params, onSuccess, onFailure) ->
    new Chargeback(params).send(onSuccess, onFailure)

  chargeback_by_date: (params, onSuccess, onFailure) ->
    new ChargebackByDate(params).send(onSuccess, onFailure)

  fraud_report: (params, onSuccess, onFailure) ->
    new FraudReport(params).send(onSuccess, onFailure)

  fraud_report_by_date: (params, onSuccess, onFailure) ->
    new FraudReportByDate(params).send(onSuccess, onFailure)

  retrieval: (params, onSuccess, onFailure) ->
    new Retrieval(params).send(onSuccess, onFailure)

  retrieval_by_date: (params, onSuccess, onFailure) ->
    new RetrievalByDate(params).send(onSuccess, onFailure)

  reconcile: (params, onSuccess, onFailure) ->
    new Reconcile(params).send(onSuccess, onFailure)

  reconcile_by_date: (params, onSuccess, onFailure) ->
    new ReconcileByDate(params).send(onSuccess, onFailure)

  avs: (params, onSuccess, onFailure) ->
    new Avs(params).send(onSuccess, onFailure)

  ###
    Financial transactions
  ###
  authorize: (params, onSuccess, onFailure) ->
    new Authorize(params).send(onSuccess, onFailure)

  authorize3d: (params, onSuccess, onFailure) ->
    new Authorize3d(params).send(onSuccess, onFailure)

  credit: (params, onSuccess, onFailure) ->
    new Credit(params).send(onSuccess, onFailure)

  init_recurring_sale: (params, onSuccess, onFailure) ->
    new InitRecurringSale(params).send(onSuccess, onFailure)

  init_recurring_sale3d: (params, onSuccess, onFailure) ->
    new InitRecurringSale3d(params).send(onSuccess, onFailure)

  recurring_sale: (params, onSuccess, onFailure) ->
    new RecurringSale(params).send(onSuccess, onFailure)

  payout: (params, onSuccess, onFailure) ->
    new Payout(params).send(onSuccess, onFailure)

  sale: (params, onSuccess, onFailure) ->
    new Sale(params).send(onSuccess, onFailure)

  sale3d: (params, onSuccess, onFailure) ->
    new Sale3d(params).send(onSuccess, onFailure)

  cancel: (params, onSuccess, onFailure) ->
    new Cancel(params).send(onSuccess, onFailure)

  # keep this for backward compatibility
  void: (params, onSuccess, onFailure) ->
    this.cancel(params, onSuccess, onFailure)

  capture: (params, onSuccess, onFailure) ->
    new Capture(params).send(onSuccess, onFailure)

  refund: (params, onSuccess, onFailure) ->
    new Refund(params).send(onSuccess, onFailure)

  ###
    Financial Alternative transactions
  ###
  p24: (params, onSuccess, onFailure) ->
    new P24(params).send(onSuccess, onFailure)

  paypal_express: (params, onSuccess, onFailure) ->
    new PaypalExpress(params).send(onSuccess, onFailure)
    
  paysafecard: (params, onSuccess, onFailure) ->
    new Paysafecard(params).send(onSuccess, onFailure)
    
  sofort: (params, onSuccess, onFailure) ->
    new Sofort(params).send(onSuccess, onFailure)
    
  ppro: (params, onSuccess, onFailure) ->
    new PPRO(params).send(onSuccess, onFailure)

  ###
    Financial OBP transactions
  ###
  paysec: (params, onSuccess, onFailure) ->
    new PaySecPayin(params).send(onSuccess, onFailure)

  paysec_payout: (params, onSuccess, onFailure) ->
    new PaySecPayout(params).send(onSuccess, onFailure)

  ###
    Web Payment Form
  ###
  wpf_create: (params, onSuccess, onFailure) ->
    new WpfCreate(params).send(onSuccess, onFailure)

  wpf_reconcile: (params, onSuccess, onFailure) ->
    new WpfReconcile(params).send(onSuccess, onFailure)

module.exports = Transaction
