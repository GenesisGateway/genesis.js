// Generated by CoffeeScript 2.7.0
(function() {
  var SddBase, SddRecurringSale, TransactionTypes;

  SddBase = require('./sdd_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  SddRecurringSale = class SddRecurringSale extends SddBase {
    getTransactionType() {
      return TransactionTypes.SDD_RECURRING_SALE;
    }

  };

  module.exports = SddRecurringSale;

}).call(this);
