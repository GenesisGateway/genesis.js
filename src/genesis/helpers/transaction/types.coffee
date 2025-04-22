
_              = require 'underscore'
CardTypes      = require './pay_by_vouchers/card_types'
RedeemTypes    = require './pay_by_vouchers/redeem_types'
PaymentMethods = require '../payment/methods'

class Types

  ###
    Aura is a local Brazilian credit card.
  ###
  @AURA = 'aura'

  ###
    Argencard is a debit or credit card used in Argentina.
  ###
  @ARGENCARD = 'argencard';

  ###
     Bancontact is a local Belgian debit card scheme.
  ###
  @BANCONTACT = 'bcmc';

  ###
    A standard Authorization
  ###
  @AUTHORIZE = 'authorize'

  ###
    3D-Secure Authorization
  ###
  @AUTHORIZE_3D = 'authorize3d'

  ###
    Cabal is a local debit/credit card brand in Argentina which can be used for online purchases.
  ###
  @CABAL = 'cabal'

  ###
    Cencosud is a local credit card in Argentina
  ###
  @CENCOSUD = 'cencosud';

  ###
    A standard Sale
  ###
  @SALE = 'sale'

  ###
    3D-Secure Sale
  ###
  @SALE_3D = 'sale3d'

  ###
    Capture settles a transaction which has been authorized before.
  ###
  @CAPTURE = 'capture'

  ###
    Refunds allow to return already billed amounts to customers.
  ###
  @REFUND = 'refund'

  ###
    Void transactions undo previous transactions.
  ###
  @VOID = 'void'

  ###
    Credits (also known as Credit Fund Transfer a.k.a. CFT)
  ###
  @CREDIT = 'credit'

  ###
   Payouts transactions
  ###
  @PAYOUT = 'payout'

  ###
    A standard initial recurring
  ###
  @INIT_RECURRING_SALE = 'init_recurring_sale'

  ###
    3D-based initial recurring
  ###
  @INIT_RECURRING_SALE_3D = 'init_recurring_sale3d'

  ###
    A RecurringSale transaction is a "repeated" transaction
    which follows and references an initial transaction
  ###
  @RECURRING_SALE = 'recurring_sale'

  ###
    Nativa is an Argentinian credit card provided by the National Bank of Argentina.
  ###
  @NATIVA = 'nativa'

  ###
    Bank transfer, popular in Netherlands (via ABN)
  ###
  @ABNIDEAL = 'abn_ideal'

  ###
    Voucher-based payment
  ###
  @CASHU = 'cashu'

  ###
    Wallet-based payment
  ###
  @EZEEWALLET = 'ezeewallet'

  ###
    Neteller
  ###
  @NETELLER = 'neteller'

  ###
    POLi is Australia's most popular online real time debit payment system.
  ###
  @POLI = 'poli'

  ###
    WebMoney is a global settlement system and environment for online business activities.
  ###
  @WEBMONEY = 'webmoney'

  ###
    PayByVouchers via oBeP
  ###
  @PAYBYVOUCHER_YEEPAY = 'paybyvoucher_yeepay'

  ###
    PayByVouchers via Credit/Debit Cards
  ###
  @PAYBYVOUCHER_SALE = 'paybyvoucher_sale'

  ###
    Voucher-based payment
  ###
  @PAYSAFECARD = 'paysafecard'

  ###
    Supports payments via EPS, TeleIngreso, SafetyPay, TrustPay, ELV, Przelewy24, QIWI
  ###
  @PPRO = 'ppro'

  ###
    Bank transfer payment, popular in Germany
  ###
  @SOFORT = 'sofort'

  ###
    Global payment system, that makes instant cross-border payments
    more secure, regulated by Danish and Swiss FSA
  ###
  @INPAY = 'inpay'

  ###
    P24 is an online banking payment, popular in Poland
  ###
  @P24 = 'p24'

  ###
    Trustly is a fast and secure oBeP-style alternative payment method. It is free of charge and
    allows you to deposit money directly from your online bank account.
  ###
  @TRUSTLY_SALE = 'trustly_sale'

  ###
    Trustly is an oBeP-style alternative payment method that allows you to
    withdraw money directly from your online bank account using your bank credentials.
  ###
  @TRUSTLY_WITHDRAWAL = 'trustly_withdrawal'

  ###
    Sepa Direct Debit Payment, popular in Germany.
    Single Euro Payments Area (SEPA) allows consumers to make cashless Euro payments to
    any beneficiary located anywhere in the Euro area using only a single bank account
  ###
  @SDD_SALE = 'sdd_sale'

  ###
    Sepa Direct Debit Payout, popular in Germany.
    Processed as a SEPA CreditTransfer and can be used for all kind of payout services
    across the EU with 1 day settlement. Suitable for Gaming, Forex-Binaries, Affiliate Programs or
    Merchant payouts
  ###
  @SCT_PAYOUT = 'sct_payout'

  ###
    Sepa Direct Debit Refund Transaction.
    Refunds allow to return already billed amounts to customers.
  ###
  @SDD_REFUND = 'sdd_refund'

  ###
    Sepa Direct Debit initial recurring
  ###
  @SDD_INIT_RECURRING_SALE = 'sdd_init_recurring_sale'

  ###
    Sepa Direct Debit RecurringSale transaction is a "repeated" transaction,
    which follows and references an SDD initial transaction
  ###
  @SDD_RECURRING_SALE = 'sdd_recurring_sale'

  ###
    iDebit connects consumers to their online banking directly from checkout, enabling secure,
    real-time payments without a credit card.
    Using iDebit allows consumers to transfer funds to merchants without
    revealing their personal banking information.
    iDebit Payin is only asynchronous and uses eCheck.
  ###
  @IDEBIT_PAYIN = 'idebit_payin'

  ###
    iDebit connects consumers to their online banking directly from checkout, enabling secure,
    real-time payments without a credit card.
    Using iDebit allows consumers to transfer funds to merchants without
    revealing their personal banking information.
    iDebit Payout is only synchronous and uses eCheck.
  ###
  @IDEBIT_PAYOUT = 'idebit_payout'

  ###
    InstaDebit connects consumers to their online banking directly from checkout, enabling secure,
    real- time payments without a credit card.
    Using InstaDebit allows consumers to transfer funds to merchants without
    revealing their personal banking information.
    InstaDebit Payin is only asynchronous and uses online bank transfer.
  ###
  @INSTA_DEBIT_PAYIN = 'insta_debit_payin'

  ###
    InstaDebit connects consumers to their online banking directly from checkout, enabling secure,
    real- time payments without a credit card.
    Using InstaDebit allows consumers to transfer funds to merchants without
    revealing their personal banking information.
    InstaDebit Payout is only synchronous and uses online bank transfer.
  ###
  @INSTA_DEBIT_PAYOUT = 'insta_debit_payout'

  ###
     Bancomer offers two options for payments in Mexico, cash payment and bank transfer.
  ###
  @BANCOMER = 'bancomer'

  ###
     BancoDoBrasil - oBeP-style alternative payment method
  ###
  @BANCO_DO_BRASIL = 'banco_do_brasil'

  ###
     Bradesco is a payment service in Brazil
  ###
  @BRADESCO = 'bradesco'

  ###
    Davivienda is offering the Bill pay service which is a fast, easy and secure way to pay and
    manage your bills online to anyone, anytime in Colombia.
  ###
  @DAVIVIENDA = 'davivienda'

  ###
    Itau is a real-time online bank transfer method and a virtual card.
    Itau transaction will be soon deprecated. Please start using Online Banking transaction
    with IT bank code instead.
  ###
  @ITAU = 'itau'

  ###
    Multibanco allows Portuguese shoppers to do payments through the Internet by using
    virtual credit cards
  ###
  @MULTIBANCO = 'multibanco'

  ###
    iDeal is the most popular payment method in the Netherlands and is a real-time
    bank transfer system covering all major Dutch consumer banks.
  ###
  @IDEAL = 'ideal'

  ###
    PayU is a payment method for Czech Republic and Poland
  ###
  @PAYU = 'payu'

  ###
    PSE transaction will be soon deprecated. Please start using Online Banking transaction
    with PS bank code instead.

    PSE (Pagos Seguros en Linea) is the preferred alternative payment solution in Colombia.
    The solution consists of an interface that offers the client the option to pay for their
    online purchases in cash, directing it to their online banking.
  ###
  @PSE = 'pse'

  ###
    PostFinance is an online banking provider in Switzerland

    PostFinance transaction will be soon deprecated. Please start using
    Online Banking transaction with PF bank code instead.
  ###
  @POST_FINANCE = 'post_finance'

  ###
    Santander transaction will be soon deprecated. Please start using Online Banking transaction
    with SN bank code instead.

    Santander is an online bank transfer for ecommerce purchases. Consumers use their trusted
    home banking environment, merchants benefit from payment guarantee and swift settlement.
  ###
  @SANTANDER = 'santander'

  ###
    Citadel is an oBeP-style alternative payment method.
    It offers merchants the ability to send/receive consumer payments via the use of bank transfer
    functionality available from the consumer’s online banking website.
  *
    Payins are only asynchronous. After initiating a transaction the transaction status is set to
    pending async and the consumer is redirected to Citadel’s Instant Banking website.
  ###
  @CITADEL_PAYIN = 'citadel_payin'

  ###
    Citadel is an oBeP-style alternative payment method.
    It offers merchants the ability to send/receive consumer payments via the use of bank transfer
    functionality available from the consumer’s online banking website.
  *
    The workflow for Payouts is synchronous, there is no redirect to the Citadel’s Instant Banking
    website. There are different required fields per country, e.g. IBAN and SWIFT Code or Account
    Number and Branch Code
  ###
  @CITADEL_PAYOUT = 'citadel_payout'

  ###
    Alipay is an oBeP-style alternative payment method that allows you to pay directly with your
    ebank account. After initiating a transaction Alipay will redirect you to their page. There you
    will see a picture of a QR code, which you will have to scan with your Alipay mobile
    application.
  ###
  @ALIPAY = 'alipay'

  ###
    WeChat Pay solution offers merchants access to the over 300 million WeChat users that have
    linked payment to their WeChat account. The solution works on desktop and mobile via a QR code
    generation platform.
  ###
  @WECHAT = 'wechat'

  ###
    PaySec is an oBeP-style alternative payment method that allows you to pay directly with your
    ebank account. After initiating a transaction PaySec will redirect you to their page. There you
    will find a list with available banks to finish the payment.
  ###
  @PAYSEC_PAYIN = 'paysec'

  ###
    PaySec Payout is an oBeP-style alternative payment method that allows you to transfer money with
    your ebank account.
  ###
  @PAYSEC_PAYOUT = 'paysec_payout'

  ###
     EPS is the main bank transfer payment method in Austria. Every transaction is guaranteed
     via the scheme.
  ###
  @EPS = 'eps'

  ###
    Google Pay allows customer to purchase with credit and debit cards linked to their
    Google account.
  ###
  @GOOGLE_PAY = 'google_pay'

  ###
    African Mobile Sale, otherwise known as Charge, is an APM used to process
    Mobile network operator payments.
    It is an async payment method and will be approved once the payment is processed with
    the Mobile network operator
  ###
  @AFRICAN_MOBILE_SALE = 'african_mobile_sale'

  ###
    Apple pay is payment method working with apple devices
  ###
  @APPLE_PAY = 'apple_pay'

   ###
     Russian Mobile Sale, otherwise known as Charge, is an APM used to process
     Mobile network operator payments.

     It is an async payment method and will be approved once the payment is processed by
     the Mobile network operator.

     Notice: Russian Mobile Sale does not support refund and void.
  ###
  @RUSSIAN_MOBILE_SALE = 'russian_mobile_sale'

  ###
    PayPal transaction is a fast and easy way for buyers to pay with their PayPal account.
    It gives buyers all the transaction details at once, including order details, shipping options,
    insurance choices, and tax totals.
  ###
  @PAY_PAl = 'pay_pal'

  ###
    Method continue is a request used for 3DSv2-Method Frictionless, Challenge and Fallback flows
  ###
  @METHOD_CONTINUE = 'method_continue'

  ###
    Online Banking is an oBeP-style alternative payment method that allows you to pay directly
    with your ebank account. After initiating a transaction, the online banking will redirect
    you to their page.There you will find a list with available banks to finish the payment.
  ###
  @ONLINE_BANKING_PAYIN = 'online_banking'

  ###
    Bank Pay-out is a bank pay-out method. It allows merchants to transfer funds directly
    to customers bank accounts.
  ###
  @ONLINE_BANKING_PAYOUT = 'bank_payout'

  ###
    MyBank is an overlay banking system.
  ###
  @MY_BANK = 'my_bank';

  ###
    Cash payment methods allows customers to pay bills and online purchases in cash
    at convenient physical locations such as stores, banks, ATMs, even pharmacies in some countries.
    Usually, at checkout a voucher is generated with a barcode or another payment reference and
    the shopper can go to one of the supported shops/locations for the specific payment method and
    pay this voucher in cash.
  ###
  @CASH = 'cash'

  ###
     Banco de Occidente is a cash payment method for Colombia

     Banco de Occidente transanction will be soon deprecated. Please start using
     Online Banking transaction with BO bank code instead.
  ###
  @BANCO_DE_OCCIDENTE = 'banco_de_occidente'

  ###
    Baloto is a cash payment option in Colombia. It allows the customers to receive
    a voucher at check-out.
    The voucher can then be paid in any of the Via Boleto offices in cash.
  ###
  @BALOTO = 'baloto'

  ###
     Boleto is a payment service in Brazil
  ###
  @BOLETO = 'boleto'

  ###
     Naranja is a local credit card issued in Argentina which can be used for purchases
     over the internet.
  ###
  @NARANJA = 'naranja'

  ###
    Tarjeta Shopping is a card payment in Argentina.
   ###
  @TARJETA_SHOPPING = 'tarjeta_shopping'

  ###
    Efecty is a cash-based payment method.
  ###
  @EFECTY = 'efecty'

  ###
    OXXO is the preferred payment method in Mexico. It is a cash payment via a barcode document
    thats accepted in more than 14,000 stores.
  ###
  @OXXO = 'oxxo'

  ###
     Pago Facil is a cash-based payment used for online purchases.
  ###
  @PAGO_FACIL = 'pago_facil'

  ###
    Pix is a payment service created by the Central Bank of Brazil (BACEN), which represents
    a new way of receiving/sending money.

    Pix allows payments to be made instantly. The customer can pay bills, invoices,
    public utilities, transfer and receive credits in a facilitated manner,
    using only Pix keys (CPF/CNPJ).
  ###
  @PIX = 'pix'

  ###
     Redpagos is a cash payment in Uruguay
  ###
  @REDPAGOS = 'redpagos'

  ###
    African Mobile Payout, or otherwise known as Disbursement, is an APM used to process
    Mobile network operator payments.

    It is an async payment method and will be approved once the payment is processed with
    the Mobile network operator.
  ###
  @AFRICAN_MOBILE_PAYOUT = 'african_mobile_payout'

  ###
    Russian Mobile Payout, or otherwise known as Disbursement, is an APM used to process
    Mobile network operator payments.

    It is an async payment method and will be approved once the payment is processed by
    the Mobile network operator.

    Notice: Russian Mobile Payout does not support refund and void.
  ###
  @RUSSIAN_MOBILE_PAYOUT = 'russian_mobile_payout'

  ###
     Elo is a local Brazilian payment card
  ###
  @ELO = 'elo'

  ###
     Webpay is a Chilean real-time bank transfer method.
  ###
  @WEBPAY = 'webpay'

  ###
     TransferTo Payout is an APM which provides 3 different payment services:
     BankAccount, MobileWallet and CashPickup. Merchant sends money to a consumer.
  ###
  @TRANSFER_TO_PAYERS = 'transfer_to_payers'

  ###
    Creates a consumer based on email address. Optionally, one can provide
    billing and shipping address. Addresses will be used, if none given, in Processing or WPF APIs.
  ###
  @CREATE_CONSUMER = 'create_consumer'

  ###
     Updates consumer email and addresses.
  ###
  @UPDATE_CONSUMER = 'update_consumer'

  ###
     Disable consumer from usage until further action.
  ###
  @DISABLE_CONSUMER = 'disable_consumer'

  ###
     Enable consumer that was disabled in the past.
  ###
  @ENABLE_CONSUMER = 'enable_consumer'

  ###
    Get previously tokenized card details for a consumer.
  ###
  @GET_CONSUMER_CARDS = 'get_consumer_cards'

  ###
    Retrieves consumer details based on consumer id or email.
  ###
  @RETRIEVE_CONSUMER = 'retrieve_consumer'

  ###
    Tokenizes cardholder data and issues a corresponding token. Merchants should
    take care to save the plain-text token value in their system as once issued
    it is not possible to obtain it again. Attempting to tokenize the same cardholder
    data will issue a new token. The token can be used in the Processing API instead of
    the cardholder data.
  ###
  @TOKENIZE = 'tokenize'

  ###
     Exchanges the token with the tokenized cardholder data
  ###
  @DETOKENIZE = 'detokenize'

  ###
      Updates the tokenized data corresponding to an existing valid token.
  ###
  @UPDATE_TOKEN = 'update_token'

  ###
      Validates if a token is active, owned by a merchant, etc.
  ###
  @VALIDATE_TOKEN = 'validate_token'

  ###
      Deletes a token.
  ###
  @DELETE_TOKEN = 'delete_token'

  ###
      Exchanges the token with the tokenized masked cardholder data
  ###
  @GET_TOKENIZED_CARD = 'get_tokenized_card'

  ###
      Get cryptogram on behalf of a token that will be used for the authorization
  ###
  @CRYPTOGRAM = 'cryptogram'

  getTypes: ->
    value for key, value of @constructor

  isValidType: (type) ->
    _.indexOf( @getTypes(), type ) != -1

  getWPFTypes: ->
    [
      @constructor.AURA,
      @constructor.ARGENCARD,
      @constructor.AUTHORIZE,
      @constructor.AUTHORIZE_3D,
      @constructor.BANCONTACT,
      @constructor.CABAL,
      @constructor.CENCOSUD,
      @constructor.ELO,
      @constructor.SALE,
      @constructor.SALE_3D,
      @constructor.INIT_RECURRING_SALE,
      @constructor.INIT_RECURRING_SALE_3D,
      @constructor.CASHU,
      @constructor.PAYSAFECARD,
      @constructor.EZEEWALLET,
      @constructor.PAYBYVOUCHER_YEEPAY,
      @constructor.PPRO,
      @constructor.SOFORT,
      @constructor.NETELLER,
      @constructor.ABNIDEAL,
      @constructor.WEBMONEY,
      @constructor.POLI,
      @constructor.PAYBYVOUCHER_SALE,
      @constructor.INPAY,
      @constructor.SDD_SALE,
      @constructor.SDD_INIT_RECURRING_SALE,
      @constructor.P24,
      @constructor.TRUSTLY_SALE,
      @constructor.TRUSTLY_WITHDRAWAL,
      @constructor.CITADEL_PAYIN,
      @constructor.INSTA_DEBIT_PAYIN,
      @constructor.BANCOMER,
      @constructor.BRADESCO,
      @constructor.DAVIVIENDA,
      @constructor.ITAU,
      @constructor.MULTIBANCO,
      @constructor.IDEAL,
      @constructor.PAYU,
      @constructor.PSE,
      @constructor.POST_FINANCE,
      @constructor.SANTANDER,
      @constructor.WECHAT,
      @constructor.MY_BANK,
      @constructor.ALIPAY,
      @constructor.PAYSEC_PAYIN,
      @constructor.PAYSEC_PAYOUT,
      @constructor.EPS,
      @constructor.IDEBIT_PAYIN,
      @constructor.AFRICAN_MOBILE_SALE,
      @constructor.BANCO_DO_BRASIL,
      @constructor.APPLE_PAY,
      @constructor.RUSSIAN_MOBILE_SALE,
      @constructor.PAY_PAl,
      @constructor.CASH,
      @constructor.PAY_PAl,
      @constructor.BALOTO,
      @constructor.BANCO_DE_OCCIDENTE,
      @constructor.BOLETO,
      @constructor.CASH,
      @constructor.EFECTY,
      @constructor.OXXO,
      @constructor.PIX,
      @constructor.PAGO_FACIL,
      @constructor.REDPAGOS,
      @constructor.NARANJA,
      @constructor.TARJETA_SHOPPING,
      @constructor.AFRICAN_MOBILE_PAYOUT,
      @constructor.RUSSIAN_MOBILE_PAYOUT
    ]

  isValidWPFType: (type) ->
    _.indexOf( @getWPFTypes(), type ) != -1

  getCustomRequiredParameters: (type) ->
    rules = {}

    if type == @constructor.PPRO
      rules.payment_method = (new PaymentMethods).getMethods()

    else if type == @constructor.PAYBYVOUCHER_SALE or type == @constructor.PAYBYVOUCHER_YEEPAY
      customParameters =
        'card_type':
          (new CardTypes).getCardTypes()
        'redeem_type':
          (new RedeemTypes).getRedeemTypes()

      if type == @constructor.PAYBYVOUCHER_YEEPAY
        customParameters =
          _.extend(
            customParameters,
            'product_name':
              null
            'product_category':
              null
          )

      rules = _.extend rules, customParameters

    else if type == @constructor.CITADEL_PAYIN
      rules.merchant_customer_id = null

    else if type == @constructor.INSTA_DEBIT_PAYIN or type == @constructor.IDEBIT_PAYIN
      rules.customer_account_id = null

    return rules

module.exports = Types
