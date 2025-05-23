// Generated by CoffeeScript 2.7.0
(function() {
  var FinancialBase, Poli, TransactionTypes;

  FinancialBase = require('../financial_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  Poli = class Poli extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.POLI;
    }

  };

  module.exports = Poli;

}).call(this);
