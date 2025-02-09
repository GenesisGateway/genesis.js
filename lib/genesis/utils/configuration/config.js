// Generated by CoffeeScript 2.7.0
(function() {
  var Config, FileConfiguration, ManualConfiguration, _;

  _ = require('underscore');

  FileConfiguration = require('./file_configuration');

  ManualConfiguration = require('./manual_configuration');

  Config = (function() {
    class Config {
      constructor(configuration) {
        this.configuration = configuration;
        this.initConfig();
      }

      getConfig() {
        return this.config;
      }

      initConfig() {
        switch (this.handleConfigType()) {
          case this.MANUAL:
            return this.config = (new ManualConfiguration(this.configuration)).getConfigObject();
          default:
            return this.config = (new FileConfiguration()).getConfigObject();
        }
      }

      handleConfigType() {
        if (this.configuration !== null) {
          return ManualConfiguration.getType();
        } else {
          return FileConfiguration.getType();
        }
      }

      getCustomerUsername() {
        return this.getConfig().customer.username;
      }

      getCustomerPassword() {
        return this.getConfig().customer.password;
      }

      getCustomerToken() {
        return this.getConfig().customer.token;
      }

      getCustomerForceSmartRouter() {
        return this.getConfig().customer.force_smart_routing || false;
      }

      getGatewayProtocol() {
        return this.getConfig().gateway.protocol || 'https';
      }

      getGatewayHostname() {
        return this.getConfig().gateway.hostname;
      }

      getGatewayTimeout() {
        return this.getConfig().gateway.timeout || '60000';
      }

      getGatewayTesting() {
        return this.getConfig().gateway.testing;
      }

      getNotificationHost() {
        return this.getConfig().notifications.host;
      }

      getNotificationPort() {
        return this.getConfig().notifications.port;
      }

      getNotificationPath() {
        return this.getConfig().notifications.path;
      }

      getNotifications() {
        return this.getConfig().notifications;
      }

      getVersion() {
        return this.VERSION;
      }

    };

    // Manual configuration identifier
    Config.prototype.MANUAL = 'manual';

    // Version configuration identifier
    Config.prototype.VERSION = '3.3.1';

    return Config;

  }).call(this);

  module.exports = Config;

}).call(this);
