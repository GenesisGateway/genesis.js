
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
Poli                = require './transactions/financial/alternative/poli'
Paysafecard         = require './transactions/financial/alternative/paysafecard'
Sofort              = require './transactions/financial/alternative/sofort'
PPRO                = require './transactions/financial/alternative/ppro'
TrustlySale         = require './transactions/financial/alternative/trustly/sale'
TrustlyWithdrawal   = require './transactions/financial/alternative/trustly/withdrawal'

###
  Financial OBP transactions
###
PaySecPayin         = require './transactions/financial/obp/paysec/payin'
PaySecPayout        = require './transactions/financial/obp/paysec/payout'
Wechat              = require './transactions/financial/obp/wechat'
Alipay              = require './transactions/financial/obp/alipay'
IDebitPayin         = require './transactions/financial/obp/idebit/payin'
IDebitPayout        = require './transactions/financial/obp/idebit/payout'
InstaDebitPayin     = require './transactions/financial/obp/insta_debit/payin'
InstaDebitPayout    = require './transactions/financial/obp/insta_debit/payout'

###
  Direct Debit
###
SddSale              = require './transactions/financial/direct_debit/sdd_sale'
SddInitRecurringSale = require './transactions/financial/direct_debit/sdd_init_recurring_sale'
SddRecurringSale     = require './transactions/financial/direct_debit/sdd_recurring_sale'
SddRefund            = require './transactions/financial/direct_debit/sdd_refund'

###
  Financial mobile transactions
###
GooglePay = require './transactions/financial/mobile/google_pay'
ApplePay  = require './transactions/financial/mobile/apple_pay'
PayPal    = require './transactions/financial/wallets/pay_pal'

###
  Vouchers
###
CashU = require './transactions/financial/vouchers/cashu'

###
  MethodContinue
###
MethodContinue = require './transactions/financial/cards/threeds/v2/method_continue'

class Transaction

  ###
    Non Financial transactions
  ###
  account_verification: (params) ->
    new AccountVerification(params)

  blacklist: (params) ->
    new Blacklist(params)

  chargeback: (params) ->
    new Chargeback(params)

  chargeback_by_date: (params) ->
    new ChargebackByDate(params)

  fraud_report: (params) ->
    new FraudReport(params)

  fraud_report_by_date: (params) ->
    new FraudReportByDate(params)

  retrieval: (params) ->
    new Retrieval(params)

  retrieval_by_date: (params) ->
    new RetrievalByDate(params)

  reconcile: (params) ->
    new Reconcile(params)

  reconcile_by_date: (params) ->
    new ReconcileByDate(params)

  avs: (params) ->
    new Avs(params)

  ###
    Financial transactions
  ###
  authorize: (params) ->
    new Authorize(params)

  authorize3d: (params) ->
    new Authorize3d(params)

  credit: (params) ->
    new Credit(params)

  init_recurring_sale: (params) ->
    new InitRecurringSale(params)

  init_recurring_sale3d: (params) ->
    new InitRecurringSale3d(params)

  recurring_sale: (params) ->
    new RecurringSale(params)

  payout: (params) ->
    new Payout(params)

  sale: (params) ->
    new Sale(params)

  sale3d: (params) ->
    new Sale3d(params)

  cancel: (params) ->
    new Cancel(params)

  # keep this for backward compatibility
  void: (params) ->
    this.cancel(params)

  capture: (params) ->
    new Capture(params)

  refund: (params) ->
    new Refund(params)

  method_continue: (params) ->
    new MethodContinue(params)

  ###
    Financial Alternative transactions
  ###
  p24: (params) ->
    new P24(params)

  poli: (params) ->
    new Poli(params)

  paysafecard: (params) ->
    new Paysafecard(params)
    
  sofort: (params) ->
    new Sofort(params)
    
  ppro: (params) ->
    new PPRO(params)
    
  trustly_sale: (params) ->
    new TrustlySale(params)
    
  trustly_withdrawal: (params) ->
    new TrustlyWithdrawal(params)

  cashu: (params) ->
    new CashU(params)

  ###
    Financial OBP transactions
  ###
  paysec: (params) ->
    new PaySecPayin(params)

  paysec_payout: (params) ->
    new PaySecPayout(params)

  wechat: (params) ->
    new Wechat(params)

  alipay: (params) ->
    new Alipay(params)

  idebit_payin: (params) ->
    new IDebitPayin(params)

  idebit_payout: (params) ->
    new IDebitPayout(params)

  insta_debit_payin: (params) ->
    new InstaDebitPayin(params)

  insta_debit_payout: (params) ->
    new InstaDebitPayout(params)

  ###
    Direct Debit
  ###
  sdd_sale: (params) ->
    new SddSale(params)

  sdd_init_recurring_sale: (params) ->
    new SddInitRecurringSale(params)

  sdd_recurring_sale: (params) ->
    new SddRecurringSale(params)

  sdd_refund: (params) ->
    new SddRefund(params)

  ###
    Web Payment Form
  ###
  wpf_create: (params) ->
    new WpfCreate(params)

  wpf_reconcile: (params) ->
    new WpfReconcile(params)

  ###
    Financial mobile transactions
  ###
  google_pay: (params) ->
    new GooglePay(params)

  apple_pay: (params) ->
    new ApplePay(params)

  ###
    Financial Wallets transactions
  ###
  pay_pal: (params) ->
    new PayPal(params)

module.exports = Transaction
