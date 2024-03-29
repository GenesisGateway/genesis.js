// Generated by CoffeeScript 2.7.0
(function() {
  var RedeemTypes, _;

  _ = require('underscore');

  RedeemTypes = (function() {
    class RedeemTypes {
      getRedeemTypes() {
        var key, ref, results, value;
        ref = this.constructor;
        results = [];
        for (key in ref) {
          value = ref[key];
          results.push(value);
        }
        return results;
      }

      isValidRedeemType(type) {
        return _.indexOf(this.getRedeemTypes(), type) !== -1;
      }

    };

    /*
      The amount value is stored in the voucher and can be used later on at any merchant outlet
      supporting the voucher card brand
    */
    RedeemTypes.STORED = 'stored';

    /*
      The voucher is issued, the amount value is transferred into it, and then immediately redeemed to
      the merchant
    */
    RedeemTypes.INSTANT = 'instant';

    return RedeemTypes;

  }).call(this);

  module.exports = RedeemTypes;

}).call(this);
