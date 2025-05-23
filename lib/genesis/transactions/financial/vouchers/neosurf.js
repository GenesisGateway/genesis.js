// Generated by CoffeeScript 2.7.0
(function() {
  var FinancialBase, Neosurf, TransactionTypes;

  FinancialBase = require('../financial_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  Neosurf = class Neosurf extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.NEOSURF;
    }

  };

  module.exports = Neosurf;

}).call(this);
