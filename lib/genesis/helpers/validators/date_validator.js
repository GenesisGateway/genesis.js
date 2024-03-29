// Generated by CoffeeScript 2.7.0
(function() {
  var DateValidator, Validator, moment;

  Validator = require('./validator');

  moment = require('moment');

  DateValidator = class DateValidator extends Validator {
    constructor(format = 'YYYY-MM-DD') {
      super();
      this.format = format;
    }

    isValid(value) {
      return moment(value, this.format, true).isValid();
    }

    getMessage(field) {
      return `Field ${field} has invalid date format. Expected format is ${this.format}`;
    }

  };

  module.exports = DateValidator;

}).call(this);
