// Generated by CoffeeScript 2.5.1
(function() {
  var Authorize, CardBase, TransactionTypes;

  CardBase = require('./card_base');

  TransactionTypes = require('../../../helpers/transaction/types');

  Authorize = class Authorize extends CardBase {
    getTransactionType() {
      return TransactionTypes.AUTHORIZE;
    }

  };

  module.exports = Authorize;

}).call(this);