Config              = require './utils/configuration/config'

###
  Financial transactions
###
Aura                = require './transactions/financial/cards/aura'
Argencard           = require './transactions/financial/cards/argencard'
Authorize           = require './transactions/financial/cards/authorize'
Authorize3d         = require './transactions/financial/cards/authorize3d'
Bancontact          = require './transactions/financial/cards/bancontact'
Cabal               = require './transactions/financial/cards/cabal'
Cencosud            = require './transactions/financial/cards/cencosud'
Elo                 = require './transactions/financial/cards/elo'
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
Nativa              = require './transactions/financial/cards/nativa'
Naranja             = require './transactions/financial/cards/naranja'
TarjetaShopping     = require './transactions/financial/cards/tarjeta_shopping'

###
  CashPayment
###
Cash                = require './transactions/financial/cash_payments/cash'
BancoDeOccidente    = require './transactions/financial/cash_payments/banco_de_occidente'
Baloto              = require './transactions/financial/cash_payments/baloto'
Boleto              = require './transactions/financial/cash_payments/boleto'
Efecty              = require './transactions/financial/cash_payments/efecty'
Oxxo                = require './transactions/financial/cash_payments/oxxo'
PagoFacil           = require './transactions/financial/cash_payments/pago_facil'
Pix                 = require './transactions/financial/cash_payments/pix'
Redpagos            = require './transactions/financial/cash_payments/redpagos'

###
  Non Financial transactions
###
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
Paysafecard         = require './transactions/financial/alternative/paysafecard'
Sofort              = require './transactions/financial/alternative/sofort'
PPRO                = require './transactions/financial/alternative/ppro'
TrustlySale         = require './transactions/financial/alternative/trustly/sale'
TrustlyWithdrawal   = require './transactions/financial/alternative/trustly/withdrawal'

###
  Financial OBP transactions
###
Wechat              = require './transactions/financial/obp/wechat'
Alipay              = require './transactions/financial/obp/alipay'
IDebitPayin         = require './transactions/financial/obp/idebit/payin'
IDebitPayout        = require './transactions/financial/obp/idebit/payout'
InstaDebitPayin     = require './transactions/financial/obp/insta_debit/payin'
InstaDebitPayout    = require './transactions/financial/obp/insta_debit/payout'
OnlineBankingPayin  = require './transactions/financial/obp/online_banking/payin'
OnlineBankingPayout = require './transactions/financial/obp/online_banking/payout'
MyBank              = require './transactions/financial/obp/my_bank'
Bancomer            = require './transactions/financial/obp/bancomer'
BancoDoBrasil       = require './transactions/financial/obp/banco_do_brasil'
Bradesco            = require './transactions/financial/obp/bradesco'
Davivienda          = require './transactions/financial/obp/davivienda'
Eps                 = require './transactions/financial/obp/eps'
Itau                = require './transactions/financial/obp/itau'
Multibanco          = require './transactions/financial/obp/multibanco'
P24                 = require './transactions/financial/obp/p24'
Ideal               = require './transactions/financial/obp/ideal'
Payu                = require './transactions/financial/obp/payu'
Poli                = require './transactions/financial/obp/poli'
Pse                 = require './transactions/financial/obp/pse'
PostFinance         = require './transactions/financial/obp/post_finance'
Santander           = require './transactions/financial/obp/santander'
Webpay              = require './transactions/financial/obp/webpay'

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
GooglePay         = require './transactions/financial/mobile/google_pay'
ApplePay          = require './transactions/financial/mobile/apple_pay'
AfricanMobileSale = require './transactions/financial/mobile/african_mobile_sale'
PayPal            = require './transactions/financial/wallets/pay_pal'
RussianMobileSale = require './transactions/financial/mobile/russian_mobile_sale'

###
  Financial Payout transactions
###
AfricanMobilePayout = require './transactions/financial/payout/african_mobile_payout'


###
  Financial payout transactions
###
RussianMobilePayout = require './transactions/financial/payout/russian_mobile_payout'


###
  Vouchers
###
CashU = require './transactions/financial/vouchers/cashu'

###
  MethodContinue
###
MethodContinue     = require './transactions/financial/cards/threeds/v2/method_continue'

OnlineBankingPayin = require './transactions/financial/obp/online_banking/payin'

class Transaction

  constructor: ( configuration = null ) ->
    @config = new Config(configuration)

  ###
      Financial Alternative transactions
    ###
  p24: (params) ->
    new P24(params, @config)

  poli: (params) ->
    new Poli(params, @config)

  paysafecard: (params) ->
    new Paysafecard(params, @config)

  sofort: (params) ->
    new Sofort(params, @config)

  ppro: (params) ->
    new PPRO(params, @config)

  trustly_sale: (params) ->
    new TrustlySale(params, @config)

  trustly_withdrawal: (params) ->
    new TrustlyWithdrawal(params, @config)

  cashu: (params) ->
    new CashU(params, @config)

  ###
    Financial transactions
  ###
  aura: (params) ->
    new Aura(params, @config)

  argencard: (params) ->
    new Argencard(params, @config)

  authorize: (params) ->
    new Authorize(params, @config)

  authorize3d: (params) ->
    new Authorize3d(params, @config)

  bcmc: (params) ->
    new Bancontact(params, @config)

  cabal: (params) ->
    new Cabal(params, @config)

  cencosud: (params) ->
    new Cencosud(params, @config)

  credit: (params) ->
    new Credit(params, @config)

  elo: (params) ->
    new Elo(params, @config)

  init_recurring_sale: (params) ->
    new InitRecurringSale(params, @config)

  init_recurring_sale3d: (params) ->
    new InitRecurringSale3d(params, @config)

  recurring_sale: (params) ->
    new RecurringSale(params, @config)

  payout: (params) ->
    new Payout(params, @config)

  sale: (params) ->
    new Sale(params, @config)

  sale3d: (params) ->
    new Sale3d(params, @config)

  cancel: (params) ->
    new Cancel(params, @config)

  # keep this for backward compatibility
  void: (params) ->
    this.cancel(params, @config)

  capture: (params) ->
    new Capture(params)

  refund: (params) ->
    new Refund(params, @config)

  method_continue: (params) ->
    new MethodContinue(params, @config)

  nativa: (params) ->
    new Nativa(params, @config)

  naranja: (params) ->
    new Naranja(params, @config)

  tarjeta_shopping: (params) ->
    new TarjetaShopping(params, @config)

  ###
    Cash Payments transactions
  ###
  baloto: (params) ->
    new Baloto(params, @config)

  banco_de_occidente: (params) ->
    new BancoDeOccidente(params, @config)

  boleto: (params) ->
    new Boleto(params, @config)

  cash: (params) ->
    new Cash(params, @config)

  efecty: (params) ->
    new Efecty(params, @config)

  oxxo: (params) ->
    new Oxxo(params, @config)

  pago_facil: (params) ->
    new PagoFacil(params, @config)

  pix: (params) ->
    new Pix(params, @config)

  redpagos: (params) ->
    new Redpagos(params, @config)

  ###
    Direct Debit
  ###
  sdd_sale: (params) ->
    new SddSale(params, @config)

  sdd_init_recurring_sale: (params) ->
    new SddInitRecurringSale(params, @config)

  sdd_recurring_sale: (params) ->
    new SddRecurringSale(params, @config)

  sdd_refund: (params) ->
    new SddRefund(params, @config)

  ###
    Financial mobile transactions
  ###
  google_pay: (params) ->
    new GooglePay(params, @config)

  african_mobile_sale: (params) ->
    new AfricanMobileSale(params, @config)

  apple_pay: (params) ->
    new ApplePay(params, @config)

  russian_mobile_sale: (params) ->
    new RussianMobileSale(params, @config)

  ###
    Financial payout transactions
  ###
  russian_mobile_payout: (params) ->
    new RussianMobilePayout(params, @config)

  ###
    Financial OBP transactions
  ###
  wechat: (params) ->
    new Wechat(params, @config)

  alipay: (params) ->
    new Alipay(params, @config)

  idebit_payin: (params) ->
    new IDebitPayin(params, @config)

  idebit_payout: (params) ->
    new IDebitPayout(params, @config)

  insta_debit_payin: (params) ->
    new InstaDebitPayin(params, @config)

  insta_debit_payout: (params) ->
    new InstaDebitPayout(params, @config)

  bradesco: (params) ->
    new Bradesco(params, @config)

  davivienda: (params) ->
    new Davivienda(params, @config)

  eps: (params) ->
    new Eps(params, @config)

  itau: (params) ->
    new Itau(params, @config)

  multibanco: (params) ->
    new Multibanco(params, @config)

  ideal: (params) ->
    new Ideal(params, @config)

  payu: (params) ->
    new Payu(params, @config)

  pse: (params) ->
    new Pse(params, @config)

  post_finance: (params) ->
    new PostFinance(params, @config)

  santander: (params) ->
    new Santander(params, @config)

  online_banking_payin: (params) ->
    new OnlineBankingPayin(params, @config)

  online_banking_payout: (params) ->
    new OnlineBankingPayout(params, @config)

  my_bank: (params) ->
    new MyBank(params, @config)

  bancomer: (params) ->
    new Bancomer(params, @config)

  banco_do_brasil: (params) ->
    new BancoDoBrasil(params, @config)

  webpay: (params) ->
    new Webpay(params, @config)

  ###
    Financial Payout transactions
  ###
  african_mobile_payout: (params) ->
    new AfricanMobilePayout(params, @config)

  ###
    Financial Wallets transactions
  ###
  pay_pal: (params) ->
    new PayPal(params, @config)

  ###
    Non Financial transactions
  ###
  blacklist: (params) ->
    new Blacklist(params, @config)

  chargeback: (params) ->
    new Chargeback(params, @config)

  chargeback_by_date: (params) ->
    new ChargebackByDate(params, @config)

  fraud_report: (params) ->
    new FraudReport(params, @config)

  fraud_report_by_date: (params) ->
    new FraudReportByDate(params, @config)

  retrieval: (params) ->
    new Retrieval(params, @config)

  retrieval_by_date: (params) ->
    new RetrievalByDate(params, @config)

  reconcile: (params) ->
    new Reconcile(params, @config)

  reconcile_by_date: (params) ->
    new ReconcileByDate(params, @config)

  avs: (params) ->
    new Avs(params, @config)

  ###
    Web Payment Form
  ###
  wpf_create: (params) ->
    new WpfCreate(params, @config)

  wpf_reconcile: (params) ->
    new WpfReconcile(params, @config)



module.exports = Transaction
