// Generated by CoffeeScript 2.7.0
(function() {
  /*
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.

  @license http://opensource.org/licenses/MIT The MIT License
  */
  var Validator, _, ajv;

  ajv = require('ajv');

  _ = require('underscore');

  // Request Validator module
  Validator = class Validator {
    constructor(trx) {
      this.trx = trx;
      this.baseUrl = 'https://genesis.js/';
      this.validationErrors = [];
      this.isConfigSchema = false;
      this.ajv = new ajv({
        allErrors: true
      });
      // load definitions schema
      this.ajv.addSchema(require('../../../schemas/definitions/definitions.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/country.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/currency.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/i18n.json'));
      // Attributes
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/business_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/sca_params.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/threeds/v1/threeds_v1.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/threeds/v2/threeds_v2.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/threeds/v1/mpi_params.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/wpf/transaction_types.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/common.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/payment.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/tokenization.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/customer/address.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/recurring/managed_recurring.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/risk_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/dynamic_descriptor_params.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/travel_data/' + 'travel_data_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/cof_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/funding_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/account_owner_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/tokenization/tokenization_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/kyc/customer_information.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/kyc/common.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/installment_attributes.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/purpose_of_payment.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/' + 'dynamic_descriptor_merchant_name.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/' + 'dynamic_descriptor_merchant_name_sdd.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/tokenization_params.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/digital_asset_types.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/crypto/bitpay/country.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/crypto/bitpay/currency.json'));
      this.ajv.addSchema(require('../../../schemas/definitions/attributes/financial/id_type.json'));
    }

    // Compare the specific transaction schema against the request parameters
    isValid() {
      var error;
      try {
        this.schema = require('../../../schemas/' + this.trx.getTransactionType() + '.json');
      } catch (error1) {
        error = error1;
        this.addError({
          message: 'JSON schema not found for this request'
        });
        return false;
      }
      return this.ajv.validate(this.schema, this.trx.getData());
    }

    isValidConfig() {
      var error;
      this.isConfigSchema = true;
      try {
        this.schema = require('../../../schemas/config/config.json');
      } catch (error1) {
        error = error1;
        this.addError({
          message: 'JSON schema not found for this request'
        });
        return false;
      }
      return this.ajv.validate(this.schema, this.trx.configuration.getConfig());
    }

    // Get all ajv errors
    // Possible with ajv allErrors: true option
    getErrors() {
      var error, i, len, ref1;
      if (this.ajv.errors) {
        ref1 = this.ajv.errors;
        for (i = 0, len = ref1.length; i < len; i++) {
          error = ref1[i];
          this.setError(error);
        }
      }
      return this.validationErrors;
    }

    // Check for predefined error messages by error.keyword
    setError(error) {
      var message;
      // add error messages for invalid properties value
      if (_.indexOf(['required', 'additionalProperties', 'const', 'enum', 'maxLength', 'minLength', 'type', 'pattern', 'format', 'minimum', 'maximum', 'dependencies', 'anyOf', 'oneOf', 'maxItems'], error.keyword) !== -1) {
        message = this.getPreDefinedErrorMessage(error);
      }
      if (message) {
        return this.addError({
          "type": error.keyword,
          "property": this.getPropertyName(error),
          "message": message
        });
      }
    }

    addError(error) {
      return this.validationErrors.push(error);
    }

    // Extract the affected property
    getPropertyName(error) {
      var parts;
      parts = [];
      if (error.dataPath) {
        parts = error.dataPath.split('.');
      }
      switch (error.keyword) {
        case 'additionalProperties':
          parts.push(error.params.additionalProperty);
          break;
        case 'required':
          parts.push(error.params.missingProperty);
          break;
        case 'dependencies':
          parts.push(error.params.property);
      }
      return _.compact(parts).join('.');
    }

    // Get user friendly error for error.keyword 'additionalProperties'
    getAdditionalErrorMessage(error) {
      return `Not allowed field ${this.getPropertyName(error)}`;
    }

    // Get user friendly error for error.keyword required
    getRequiredErrorMessage(error) {
      return `Field ${this.getPropertyName(error)} is required${this.getRequiredErrorMessageSuffix(error)}`;
    }

    // Build the specific error suffix based on the error.keyword and the given schema logic
    // TODO consider removing it, AJV doesn't return schemaPath for if then
    getRequiredErrorMessageSuffix(error) {
      var property, ref, ref1, refSchema, schema, suffix, value;
      suffix = '';
      refSchema = this.getRefErrorSchema(error);
      schema = this.ajv.getSchema(`${this.baseUrl}${this.trx.getTransactionType()}`);
      ref = refSchema ? refSchema.split('#') : void 0;
      ref = ref[1] ? ref[1].split('/') : ref;
      if (ref[1] === 'then' && schema.refVal[schema.refs[refSchema]]) {
        ref1 = schema.refVal[schema.refs[refSchema]]['if'].properties;
        for (property in ref1) {
          value = ref1[property];
          suffix += suffix ? ' and ' : ' when ';
          suffix += `${property} is `;
          if (value.enum) {
            suffix += value.enum.join(" or ");
          } else if (value.const) {
            suffix += value.const;
          } else {
            suffix += 'present';
          }
        }
      }
      return suffix;
    }

    // Get predefined error message
    // If error.keyword is not set then the default ajv error message will be displayed
    getPreDefinedErrorMessage(error) {
      var suffix;
      suffix = this.getMessage(error) || (function() {
        switch (error.keyword) {
          case 'required':
            return this.getRequiredErrorMessage(error);
          case 'additionalProperties':
            return this.getAdditionalErrorMessage(error);
          case 'const':
            return `Allowed value is ${error.params.allowedValue}`;
          case 'enum':
            return `Allowed values are ${error.params.allowedValues.join(', ')}`;
          case 'maxLength':
            return `Should be string shorter or equal ${error.params.limit}`;
          case 'minLength':
            return `Should be string longer or equal ${error.params.limit}`;
          case 'type':
            return `Should be ${error.params.type}`;
          case 'pattern':
            return `Should match pattern ${error.params.pattern}`;
          case 'format':
            return `Should be valid ${error.params.format}`;
          case 'dependencies':
            return `Request ${error.message}`;
          case 'anyOf':
            return "Check API Documentation.";
          default:
            return '';
        }
      }).call(this);
      if (suffix) {
        suffix = `. ${suffix}`;
      }
      return `${this.getMessagePrefix(error)}${suffix}`;
    }

    switchSchema() {
      if (this.isConfigSchema === true) {
        return this.ajv.getSchema(`${this.baseUrl}config`);
      } else {
        return this.ajv.getSchema(`${this.baseUrl}${this.trx.getTransactionType()}`);
      }
    }

    getMessage(error) {
      var message, ref, schema;
      ref = this.getRefErrorSchema(error);
      schema = this.switchSchema();
      // The schema property predefined message has first priority
      message = this.getPropertyMessage(ref, schema, error.keyword);
      if (!_.isEmpty(message)) {
        return message;
      }
      // The pre-defined schema message has second priority
      message = this.getCustomMessage(schema.schema, error.keyword);
      if (!_.isEmpty(message)) {
        return message;
      }
      // The external schemas property messages are last
      message = this.getMessageFromRef(ref, error.keyword);
      if (!_.isEmpty(message)) {
        return message;
      }
    }

    // User friendly message prefix
    getMessagePrefix(error) {
      switch (error.keyword) {
        case 'anyOf':
        case 'oneOf':
          return "Request depends on specific rules";
        case 'additionalProperties':
          return "Request contain invalid field";
        default:
          return `Field ${this.getPropertyName(error)} has invalid value`;
      }
    }

    // Extract the pre-defined message from a property
    getPropertyMessage(ref, schema, keyword) {
      var property, propertyName;
      if (schema.refVal[schema.refs[ref]]) {
        property = schema.refVal[schema.refs[ref]];
        propertyName = ref.split('#');
        if (property.properties && property.properties[propertyName[1]]) {
          property = property.properties[propertyName[1]];
        }
        return this.getCustomMessage(property, keyword);
      }
    }

    // Extract the pre-defined message from a schema
    getMessageFromRef(ref, keyword) {
      var refSchema;
      refSchema = this.ajv.getSchema(ref);
      if (!refSchema) {
        return '';
      }
      return this.getCustomMessage(refSchema.schema, keyword);
    }

    // Get the pre-defined message
    getCustomMessage(object, keyword) {
      if (object.message) {
        return object.message;
      }
      if (object.messages) {
        if (_.isArray(object.messages[keyword])) {
          return object.messages[keyword].join(' ');
        }
        return object.messages[keyword];
      }
    }

    // Get the schema that raise error
    getRefErrorSchema(error) {
      var ref, refPath, url;
      refPath = error.schemaPath.split('#');
      if (_.isEmpty(refPath[0])) {
        refPath[0] = this.trx.getTransactionType();
      }
      ref = refPath[0].startsWith('/') ? refPath[0].substring(1) : refPath[0];
      if (refPath[1]) {
        url = refPath[1].replace("/properties/", "").split('/');
        url = (url.includes('then') || url.includes('if')) ? url.join('/') : url[0];
        ref = `${this.baseUrl}${ref}#${url}`;
      }
      return ref;
    }

  };

  module.exports = Validator;

}).call(this);
