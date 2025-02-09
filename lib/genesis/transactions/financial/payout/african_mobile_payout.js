// Generated by CoffeeScript 2.7.0
(function() {
  var AfricanMobilePayout, FinancialBase, TransactionTypes;

  FinancialBase = require('../financial_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  AfricanMobilePayout = class AfricanMobilePayout extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.AFRICAN_MOBILE_PAYOUT;
    }

  };

  module.exports = AfricanMobilePayout;

}).call(this);
