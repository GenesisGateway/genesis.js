// Generated by CoffeeScript 2.7.0
(function() {
  var Request, RetrievePayeeAccount, _;

  Request = require('../../../request');

  _ = require('underscore');

  /*
    Retrieve the details of a specific Account record based on its unique ID
    that belongs to specific Payee
  */
  RetrievePayeeAccount = class RetrievePayeeAccount extends Request {
    constructor(params, configuration) {
      super(params, configuration, 'get');
      this.populateIdentifiers();
    }

    getTransactionType() {
      return 'retrieve_payee_account';
    }

    // Request endpoint
    getUrl() {
      return {
        app: 'smart_router',
        path: `payee/${this.payee_unique_id}/account/${this.account_unique_id}`
      };
    }

    // Populate parameters used in the endpoint
    populateIdentifiers() {
      this.payee_unique_id = '';
      this.account_unique_id = '';
      if (this.params instanceof Object && this.params.hasOwnProperty('payee_unique_id')) {
        this.payee_unique_id = this.params.payee_unique_id;
      }
      if (this.params instanceof Object && this.params.hasOwnProperty('account_unique_id')) {
        return this.account_unique_id = this.params.account_unique_id;
      }
    }

  };

  module.exports = RetrievePayeeAccount;

}).call(this);
