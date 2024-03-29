// Generated by CoffeeScript 2.7.0
(function() {
  var CardBase, Payout, TransactionTypes;

  CardBase = require('./card_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  Payout = class Payout extends CardBase {
    getTransactionType() {
      return TransactionTypes.PAYOUT;
    }

  };

  module.exports = Payout;

}).call(this);
