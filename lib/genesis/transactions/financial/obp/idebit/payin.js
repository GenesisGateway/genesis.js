// Generated by CoffeeScript 2.7.0
(function() {
  var FinancialBase, IDebitPayin, StringValidator, TransactionTypes, _;

  FinancialBase = require('../../financial_base');

  TransactionTypes = require('../../../../helpers/transaction/types');

  _ = require('underscore');

  StringValidator = require('../../../../helpers/validators/string_validator');

  IDebitPayin = class IDebitPayin extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.IDEBIT_PAYIN;
    }

    constructor(params, configuration) {
      super(params, configuration);
    }

  };

  module.exports = IDebitPayin;

}).call(this);
