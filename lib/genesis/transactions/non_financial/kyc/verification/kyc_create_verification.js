// Generated by CoffeeScript 2.7.0
(function() {
  var KycCreateVerification, Request;

  Request = require('../../../../request');

  /*
    The verification request will provide a link that will be used to redirect
    the customer. The customer will provide the required documents and will be
    verified against them. As a result, the user will be redirected back to merchant
    based on the provided redirect URL.
  */
  KycCreateVerification = class KycCreateVerification extends Request {
    constructor(params, configuration) {
      super(params, configuration, 'json');
    }

    getTransactionType() {
      return 'kyc_create_verification';
    }

    getData() {
      return this.params;
    }

    getUrl() {
      return {
        app: 'kyc',
        path: 'api/v1/verifications'
      };
    }

    getTrxData() {
      return this.params;
    }

  };

  module.exports = KycCreateVerification;

}).call(this);
