// Generated by CoffeeScript 2.7.0
(function() {
  var FraudReportByDate, Request;

  Request = require('../../../../request');

  FraudReportByDate = class FraudReportByDate extends Request {
    getTransactionType() {
      return 'fraud_report_by_date_request';
    }

    getData() {
      return this.params;
    }

    getUrl() {
      return {
        app: 'gate',
        path: 'fraud_reports/by_date'
      };
    }

    getTrxData() {
      return {
        'fraud_report_request': this.params
      };
    }

  };

  module.exports = FraudReportByDate;

}).call(this);
