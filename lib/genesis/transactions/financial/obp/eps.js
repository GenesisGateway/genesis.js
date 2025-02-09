// Generated by CoffeeScript 2.7.0
(function() {
  var Eps, FinancialBase, TransactionTypes;

  FinancialBase = require('../financial_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  Eps = class Eps extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.EPS;
    }

  };

  module.exports = Eps;

}).call(this);
