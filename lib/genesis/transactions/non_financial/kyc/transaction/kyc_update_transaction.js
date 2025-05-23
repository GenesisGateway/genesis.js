// Generated by CoffeeScript 2.7.0
(function() {
  var KycUpdateTransaction, Request;

  Request = require('../../../../request');

  /*
    Utilize this method to update a particular transaction status so we can continue
    improving the data models and provide the best scores and recommendations.
  */
  KycUpdateTransaction = class KycUpdateTransaction extends Request {
    constructor(params, configuration) {
      super(params, configuration, 'json');
    }

    getTransactionType() {
      return 'kyc_update_transaction';
    }

    getData() {
      return this.params;
    }

    getUrl() {
      return {
        app: 'kyc',
        path: 'api/v1/update_transaction'
      };
    }

    getTrxData() {
      return this.params;
    }

  };

  module.exports = KycUpdateTransaction;

}).call(this);
