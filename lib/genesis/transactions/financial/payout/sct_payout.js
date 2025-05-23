// Generated by CoffeeScript 2.7.0
(function() {
  var FinancialBase, SctPayout, TransactionTypes;

  FinancialBase = require('../financial_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  SctPayout = class SctPayout extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.SCT_PAYOUT;
    }

  };

  module.exports = SctPayout;

}).call(this);
