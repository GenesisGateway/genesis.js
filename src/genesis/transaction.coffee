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
Chargeback                      = require './transactions/non_financial/fraud/chargeback/chargeback'
ChargebackByDate                =
  require './transactions/non_financial/fraud/chargeback/chargeback_by_date'
Blacklist                       = require './transactions/non_financial/blacklist'
FraudReport                     =
  require './transactions/non_financial/fraud/reports/fraud_report'
FraudReportByDate               =
  require './transactions/non_financial/fraud/reports/fraud_report_by_date'
Retrieval                       = require './transactions/non_financial/fraud/retrieval/retrieval'
RetrievalByDate                 =
  require './transactions/non_financial/fraud/retrieval/retrieval_by_date'
Reconcile                       = require './transactions/non_financial/reconcile/reconcile'
ReconcileByDate                 = require './transactions/non_financial/reconcile/reconcile_by_date'
Payers                          =
  require './transactions/non_financial/alternatives/transfer_to/payers'
CreateConsumer                  = require './transactions/non_financial/consumers/create'
UpdateConsumer                  = require './transactions/non_financial/consumers/update'
DisableConsumer                 =
  require './transactions/non_financial/consumers/disable'
EnableConsumer                  = require './transactions/non_financial/consumers/enable'
GetCards                        = require './transactions/non_financial/consumers/get_cards'
RetrieveConsumer                = require './transactions/non_financial/consumers/retrieve'
ProcessedTransactions           =
  require './transactions/non_financial/processed_transactions/processed_transactions'
ProcessedTransactionsByDate     =
  require './transactions/non_financial/processed_transactions/processed_transactions_by_date'
ProcessedTransactionsByPostDate =
  require './transactions/non_financial/processed_transactions/processed_transactions_by_post_date'

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

###
  Tokenization
###
Tokenize         = require './transactions/non_financial/tokenization/tokenize'
UpdateToken      = require './transactions/non_financial/tokenization/update_token'
Detokenize       = require './transactions/non_financial/tokenization/detokenize'
ValidateToken    = require './transactions/non_financial/tokenization/validate_token'
DeleteToken      = require './transactions/non_financial/tokenization/delete_token'
GetTokenizedCard = require './transactions/non_financial/tokenization/get_tokenized_card'
Cryptogram       = require './transactions/non_financial/tokenization/cryptogram'

###
  FX Services
###
FxTier  = require './transactions/non_financial/fx/tier'
FxTiers = require './transactions/non_financial/fx/tiers'
FxRate  = require './transactions/non_financial/fx/rate'
FxRates = require './transactions/non_financial/fx/rates'
FxSearchRate = require './transactions/non_financial/fx/search_rate'

###
  KYC Services
###
KycCreateConsumer       =
  require './transactions/non_financial/kyc/consumer_registration/kyc_create_consumer'
KycUpdateConsumer       =
  require './transactions/non_financial/kyc/consumer_registration/kyc_update_consumer'
KycCreateTransaction    =
  require './transactions/non_financial/kyc/transaction/kyc_create_transaction'
KycUpdateTransaction    =
  require './transactions/non_financial/kyc/transaction/kyc_update_transaction'
KycUploadDocument       =
  require './transactions/non_financial/kyc/identity_document/kyc_upload_document'
KycDownloadDocument     =
  require './transactions/non_financial/kyc/identity_document/kyc_download_document'
KycMakeCall             =
  require './transactions/non_financial/kyc/call/kyc_make_call'
KycUpdateCall           =
  require './transactions/non_financial/kyc/call/kyc_update_call'
KycCreateVerification   =
  require './transactions/non_financial/kyc/verification/kyc_create_verification'
KycVerificationStatus   =
  require './transactions/non_financial/kyc/verification/kyc_verification_status'
KycVerificationRegister =
  require './transactions/non_financial/kyc/verification/kyc_verification_register'
KycCpf               = require './transactions/non_financial/kyc/cpf/kyc_cpf'
KycCnpj              = require './transactions/non_financial/kyc/cnpj/kyc_cnpj'

###
  SCA
###
ScaChecker = require './transactions/non_financial/sca/checker'

###
  Installments API services
###
InstallmentsFetch       = require './transactions/non_financial/installments/fetch'
InstallmentsShowDetails = require './transactions/non_financial/installments/show_details'

###
  Library Transaction factory
###
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
    new Capture(params, @config)

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

  transfer_to_payers: () ->
    new Payers(null, @config)

  create_consumer: (params) ->
    new CreateConsumer(params, @config)

  update_consumer: (params) ->
    new UpdateConsumer(params, @config)

  disable_consumer: (params) ->
    new DisableConsumer(params, @config)

  enable_consumer: (params) ->
    new EnableConsumer(params, @config)

  get_consumer_cards: (params) ->
    new GetCards(params, @config)

  retrieve_consumer: (params) ->
    new RetrieveConsumer(params, @config)

  processed_transactions: (params) ->
    new ProcessedTransactions(params, @config)

  processed_transactions_by_date: (params) ->
    new ProcessedTransactionsByDate(params, @config)

  processed_transactions_by_post_date: (params) ->
    new ProcessedTransactionsByPostDate(params, @config)

  ###
    Tokenization
  ###
  tokenize: (params) ->
    new Tokenize(params, @config)

  update_token: (params) ->
    new UpdateToken(params, @config)

  detokenize: (params) ->
    new Detokenize(params, @config)

  validate_token: (params) ->
    new ValidateToken(params, @config)

  delete_token: (params) ->
    new DeleteToken(params, @config)

  get_tokenized_card: (params) ->
    new GetTokenizedCard(params, @config)

  cryptogram: (params) ->
    new Cryptogram(params, @config)

  ###
    FX
  ###
  fx_tier: (params) ->
    new FxTier(params, @config)

  fx_tiers: ->
    new FxTiers(null, @config)

  fx_rate: (params) ->
    new FxRate(params, @config)

  fx_rates: (params) ->
    new FxRates(params, @config)

  fx_search_rate: (params) ->
    new FxSearchRate(params, @config)

  ###
    KYC services
  ###
  kyc_create_consumer: (params) ->
    new KycCreateConsumer(params, @config)

  kyc_update_consumer: (params) ->
    new KycUpdateConsumer(params, @config)

  kyc_create_transaction: (params) ->
    new KycCreateTransaction(params, @config)

  kyc_update_transaction: (params) ->
    new KycUpdateTransaction(params, @config)

  kyc_upload_document: (params) ->
    new KycUploadDocument(params, @config)

  kyc_download_document: (params) ->
    new KycDownloadDocument(params, @config)

  kyc_make_call: (params) ->
    new KycMakeCall(params, @config)

  kyc_update_call: (params) ->
    new KycUpdateCall(params, @config)

  kyc_cpf: (params) ->
    new KycCpf(params, @config)

  kyc_cnpj: (params) ->
    new KycCnpj(params, @config)

  kyc_create_verification: (params) ->
    new KycCreateVerification(params, @config)

  kyc_verification_status: (params) ->
    new KycVerificationStatus(params, @config)

  kyc_verification_register: (params) ->
    new KycVerificationRegister(params, @config)

  ###
    SCA
  ###
  sca_checker: (params) ->
    new ScaChecker(params, @config)

  ###
    Installments
  ###
  installments_fetch: (params) ->
    new InstallmentsFetch(params, @config)

  installments_show_details: (params) ->
    new InstallmentsShowDetails(params, @config)

  ###
    Web Payment Form
  ###
  wpf_create: (params) ->
    new WpfCreate(params, @config)

  wpf_reconcile: (params) ->
    new WpfReconcile(params, @config)



module.exports = Transaction
