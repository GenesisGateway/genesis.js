// Generated by CoffeeScript 2.7.0
(function() {
  var Reconcile, Request, config;

  Request = require('../../../request');

  config = require('config');

  Reconcile = class Reconcile extends Request {
    constructor(params, configuration) {
      super(params, configuration);
      this.configuration = configuration;
    }

    getTransactionType() {
      return 'reconcile';
    }

    getData() {
      return this.params;
    }

    getUrl() {
      return {
        app: 'gate',
        path: 'reconcile',
        token: this.configuration.getCustomerToken()
      };
    }

    getTrxData() {
      return {
        'reconcile': this.params
      };
    }

  };

  module.exports = Reconcile;

}).call(this);
