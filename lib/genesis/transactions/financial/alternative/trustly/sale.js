// Generated by CoffeeScript 2.7.0
(function() {
  var AlternativeBase, Sale, TransactionTypes;

  AlternativeBase = require('../alternative_base');

  TransactionTypes = require('../../../../helpers/transaction/types');

  Sale = class Sale extends AlternativeBase {
    getTransactionType() {
      return TransactionTypes.TRUSTLY_SALE;
    }

    constructor(params, configuration) {
      super(params, configuration);
      this.fieldsValues['billing_address.country'] = ['AT', 'BE', 'BG', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 'FI', 'FR', 'GB', 'GR', 'HR', 'HU', 'IE', 'IT', 'LT', 'LU', 'LV', 'MT', 'NL', 'NO', 'PL', 'PT', 'RO', 'SE', 'SI', 'SK'];
    }

  };

  module.exports = Sale;

}).call(this);
