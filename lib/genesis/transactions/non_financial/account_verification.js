// Generated by CoffeeScript 2.7.0
(function() {
  var AccountVerification, Base, CreditCardValidator, TransactionTypes, _, config;

  Base = require('../base');

  TransactionTypes = require('../../helpers/transaction/types');

  _ = require('underscore');

  config = require('config');

  CreditCardValidator = require('../../helpers/validators/credit_card_validator');

  AccountVerification = class AccountVerification extends Base {
    getTransactionType() {
      return TransactionTypes.ACCOUNT_VERIFICATION;
    }

    constructor(params) {
      super(params);
    }

    getUrl() {
      return {
        app: 'gate',
        path: 'process',
        token: config.customer.token
      };
    }

    getTrxData() {
      return {
        'payment_transaction': _.extend(this.params, {
          'transaction_type': this.getTransactionType()
        })
      };
    }

  };

  module.exports = AccountVerification;

}).call(this);
