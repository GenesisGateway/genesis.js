// Generated by CoffeeScript 2.7.0
(function() {
  var ThreedsUtils, _, config, crypto;

  _ = require('underscore');

  crypto = require('crypto');

  config = require('config');

  ThreedsUtils = class ThreedsUtils {
    static generateSignature(uniqueId, amount, timestamp, password) {
      return crypto.createHash('sha512').update(uniqueId + amount + timestamp + password).digest('hex');
    }

  };

  module.exports = ThreedsUtils;

}).call(this);
