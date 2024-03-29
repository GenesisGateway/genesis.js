// Generated by CoffeeScript 2.7.0
(function() {
  var Base, ReconcileByDate, config;

  Base = require('../../base');

  config = require('config');

  ReconcileByDate = class ReconcileByDate extends Base {
    constructor(params) {
      super(params);
    }

    getTransactionType() {
      return 'reconcile_by_date';
    }

    getData() {
      return this.params;
    }

    getUrl() {
      return {
        app: 'gate',
        path: 'reconcile/by_date',
        token: config.customer.token
      };
    }

    getTrxData() {
      return {
        'reconcile': this.params
      };
    }

  };

  module.exports = ReconcileByDate;

}).call(this);
