// Generated by CoffeeScript 2.7.0
(function() {
  var CashU, FinancialBase, TransactionTypes;

  FinancialBase = require('../financial_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  CashU = class CashU extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.CASHU;
    }

  };

  module.exports = CashU;

}).call(this);
