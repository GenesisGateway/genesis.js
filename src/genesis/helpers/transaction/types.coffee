
_              = require 'underscore'
CardTypes      = require './pay_by_vouchers/card_types'
RedeemTypes    = require './pay_by_vouchers/redeem_types'
PaymentMethods = require '../payment/methods'

class Types

  ###
    Address Verification
  ###
  @AVS = 'avs';

  ###
    A standard Authorization
  ###
  @AUTHORIZE = 'authorize'

  ###
    3D-Secure Authorization
  ###
  @AUTHORIZE_3D = 'authorize3d'

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
    Google Pay allows customer to purchase with credit and debit cards linked to their
    Google account.
  ###
  @GOOGLE_PAY = 'google_pay'

  ###
    Apple pay is payment method working with apple devices
  ###
  @APPLE_PAY = 'apple_pay'

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

  getTypes: ->
    value for key, value of @constructor

  isValidType: (type) ->
    _.indexOf( @getTypes(), type ) != -1

  getWPFTypes: ->
    [
      @constructor.AUTHORIZE,
      @constructor.AUTHORIZE_3D,
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
      @constructor.WECHAT,
      @constructor.ALIPAY,
      @constructor.PAYSEC_PAYIN,
      @constructor.PAYSEC_PAYOUT,
      @constructor.IDEBIT_PAYIN,
      @constructor.APPLE_PAY,
      @constructor.PAY_PAl
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
