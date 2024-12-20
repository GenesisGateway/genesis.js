// Generated by CoffeeScript 2.7.0
(function() {
  var FinancialBase, NumberValidator, PaySecPayin, TransactionTypes, _;

  FinancialBase = require('../../financial_base');

  TransactionTypes = require('../../../../helpers/transaction/types');

  _ = require('underscore');

  NumberValidator = require('../../../../helpers/validators/number_validator');

  PaySecPayin = class PaySecPayin extends FinancialBase {
    getTransactionType() {
      return TransactionTypes.PAYSEC_PAYIN;
    }

    constructor(params, configuration) {
      super(params, configuration);
      this.requiredFields = _.union(this.requiredFields, ['remote_ip', 'return_success_url', 'return_failure_url']);
      this.fieldsValues['currency'] = ['CNY', 'THB', 'IDR'];
      //Minimum amount for CNY and THB is 10.00, for IDR is 10000.00
      this.fieldsValuesConditional = {
        'currency': {
          'CNY': {
            'amount': new NumberValidator(10)
          },
          'THB': {
            'amount': new NumberValidator(10)
          },
          'IDR': {
            'amount': new NumberValidator(10000)
          }
        }
      };
    }

  };

  module.exports = PaySecPayin;

}).call(this);
